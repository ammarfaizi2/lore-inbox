Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319194AbSHTQnU>; Tue, 20 Aug 2002 12:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319193AbSHTQnU>; Tue, 20 Aug 2002 12:43:20 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:2812 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S319191AbSHTQnT>; Tue, 20 Aug 2002 12:43:19 -0400
Subject: Re: IDE-TNG what to do ?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: John Jones <little.jones.family@ntlworld.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <79A12178-B456-11D6-A001-00050291EC35@ntlworld.com>
References: <79A12178-B456-11D6-A001-00050291EC35@ntlworld.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 20 Aug 2002 17:47:10 +0100
Message-Id: <1029862030.22982.73.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-08-20 at 17:04, John Jones wrote:
> (yeah I know PCIX and vax's are still around in terms of legacy machine 
> people hang onto but I am sticking my head in the sand and 
> singing...SCSI or SAS )
> 
> really I am suggesting that you have IDE-TNG just for a few controllers 
> and drives
> (real world testing is easier)
> 
> and the way to restrict the number is to say Serial ATA only
> 
> bad or (partly)good ?


I don't think it is where the complexity is coming from. The driver
specific pieces for a relatively clean and sane UDMA PCI device are
currently at about 500 lines of code including comments and blanks.


