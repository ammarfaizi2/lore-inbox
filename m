Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289968AbSAOPeU>; Tue, 15 Jan 2002 10:34:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289973AbSAOPeJ>; Tue, 15 Jan 2002 10:34:09 -0500
Received: from smtpnotes.altec.com ([209.149.164.10]:5126 "HELO
	smtpnotes.altec.com") by vger.kernel.org with SMTP
	id <S289968AbSAOPd5>; Tue, 15 Jan 2002 10:33:57 -0500
X-Lotus-FromDomain: ALTEC
From: Wayne.Brown@altec.com
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <86256B42.0055730A.00@smtpnotes.altec.com>
Date: Tue, 15 Jan 2002 09:27:21 -0600
Subject: Re: Linux-2.5.2
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



The io_request_lock problem is still present in drivers/scsi/ppa.c:

ppa.c: In function `ppa_detect':
ppa.c:131: `io_request_lock' undeclared (first use in this function)
ppa.c:131: (Each undeclared identifier is reported only once
ppa.c:131: for each function it appears in.)
ppa.c: In function `ppa_interrupt':
ppa.c:850: `io_request_lock' undeclared (first use in this function)
make[2]: *** [ppa.o] Error 1


