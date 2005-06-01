Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261189AbVFABNO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261189AbVFABNO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 21:13:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261192AbVFABNO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 21:13:14 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:43931 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261189AbVFABNM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 21:13:12 -0400
From: Parag Warudkar <kernel-stuff@comcast.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: How to find if BIOS has already enabled the device
Date: Tue, 31 May 2005 21:12:55 -0400
User-Agent: KMail/1.8
Cc: John Livingston <jujutama@comcast.net>,
       Aleksey Gorelov <Aleksey_Gorelov@Phoenix.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <0EF82802ABAA22479BC1CE8E2F60E8C31B5206@scl-exch2k3.phoenix.com> <200505281018.18092.kernel-stuff@comcast.net> <1117296905.2356.23.camel@localhost.localdomain>
In-Reply-To: <1117296905.2356.23.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505312112.56014.kernel-stuff@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 28 May 2005 12:15, Alan Cox wrote:
> On Sad, 2005-05-28 at 15:18, Parag Warudkar wrote:
> > dmesg is perfectly normal, not even timestamp differences before and
> > after call to pci_enable_device - since the machine is completely hung
> > for that period - not even the clock is ticking?
>
> A spurious jammed IRQ is one candidate - but you haven't provided dmesg
> data
>
Whoa - 2.6.12-rc5 automagically fixes this one! 2 *minutes* cut from boot 
time!! BTW - this was present from 2.6.9.

Parag
