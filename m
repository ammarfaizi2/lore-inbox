Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264797AbTCCM0t>; Mon, 3 Mar 2003 07:26:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264811AbTCCM0t>; Mon, 3 Mar 2003 07:26:49 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:28826
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264797AbTCCM0s>; Mon, 3 Mar 2003 07:26:48 -0500
Subject: Re: Problem with aacraid driver in 2.5.63-bk-latest
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Christoffer Hall-Frederiksen <hall@jiffies.dk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030303100515.GA2697@jiffies.dk>
References: <20030303100515.GA2697@jiffies.dk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1046698844.5890.2.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 03 Mar 2003 13:40:44 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-03-03 at 10:05, Christoffer Hall-Frederiksen wrote:
> I've tried this one on linux-scsi but to no avail, here is a resend to
> lkml.
> 
> I have a dell poweredge 1650 with a perc3/DI raid controller. When the
> AACRAID driver loads it prints the following lines:
> 
> AAC0: kernel 2.7.4 build 3170
> AAC0: monitor 2.7.4 build 3170
> AAC0: bios 2.7.0 build 3170
> AAC0: serial 0b9c810d3
> scsi0 : percraid

Its freezing after setup somewhere. There have been a lot of scsi changes
and not all of them are ones I've checked with aacraid. The osdl guys have
actually done pretty much all the work so far.

First things to try

Does it hang with SMP/Pre-empt off
Where does the nmi lockbreaker show it hanging 

