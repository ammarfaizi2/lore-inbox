Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283610AbRK3LHy>; Fri, 30 Nov 2001 06:07:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283615AbRK3LHo>; Fri, 30 Nov 2001 06:07:44 -0500
Received: from f48.pav2.hotmail.com ([64.4.37.48]:63760 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S283610AbRK3LHZ>;
	Fri, 30 Nov 2001 06:07:25 -0500
X-Originating-IP: [156.153.255.126]
From: "kumar M" <kumarm4@hotmail.com>
To: linux-kernel@vger.kernel.org
Cc: kumarm4@hotmail.com
Subject: Problems in exporting symbols
Date: Fri, 30 Nov 2001 11:07:17 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F48yAE0Q2KxYx9KJlzK00004f4a@hotmail.com>
X-OriginalArrivalTime: 30 Nov 2001 11:07:20.0155 (UTC) FILETIME=[2DF74AB0:01C1798F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am attempting to process Scsi Requests for implementaion of a
customised target mode driver through my kernel module.
FOr achieving this, I have declared a global pointer 'my_request' of
Scsi_Request type, and duly  allocated (using scsi_allocate_request ) in the 
scan_scsis_single function.
I am exporting the symbol through the EXPORT_SYMBOL macro in scsi_syms.c. I 
observe that scsi_allocate_request goes thorugh fine, and able to initialise 
it.
Howewver, when I reference the same in my module while processing
at a later stage, I am obtaining an unresolved external  for
'my_request' while loading my module.
I am able to see the variable in /proc/kysms as :
my_request_R__ver_my_request

Can I get any inputs on why I am facing this problem ?
TIA,
Kumar



_________________________________________________________________
Get your FREE download of MSN Explorer at http://explorer.msn.com/intl.asp

