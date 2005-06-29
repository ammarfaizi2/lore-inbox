Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262661AbVF2VX1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262661AbVF2VX1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 17:23:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262668AbVF2VWu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 17:22:50 -0400
Received: from wproxy.gmail.com ([64.233.184.199]:32344 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262648AbVF2VWO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 17:22:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=IoEK6D2HtxHDRT+kzgh+CnvVrIJwvzcBRkU+8PufgBdqvZSD3hAPl6xJZy2VgbxYKFvPibwUBuAKZU1zkr9iiPSZ4ysjCjP9llKFQFcHx5I+l5+Eqwc7C6YNQgQr2vC/Nckxg0UowGQ4c315Gov84gy4CTCGmFB/wOtYZVq76vQ=
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Stefano Mangione <s.mangione@gmail.com>
Subject: Re: [2.6.12] USB storage device stalls after a few KB transfer
Date: Thu, 30 Jun 2005 01:28:23 +0400
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
References: <2d4e1ff6050627115141bb2828@mail.gmail.com> <200506272042.51578.s0348365@sms.ed.ac.uk>
In-Reply-To: <200506272042.51578.s0348365@sms.ed.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506300128.23976.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 27 June 2005 23:42, Alistair John Strachan wrote:
> On Monday 27 Jun 2005 19:51, Stefano Mangione wrote:
> > The device is seen, can be mounted and the filesystem listed, but file
> > transfers run very slow, i guess they stop after a few KB.
> >
> > This happened in 2.6.12, 2.6.11.12 works well, everything else seems
> > to work perfectly. The device is a 256MB OTi Flash Disk, my USB host
> > is listed as a VIA VT6202, the motherboard is an MSI with A6712VMS
> > V1.9 072903 BIOS
> >
> > /sbin/lspci -n:
> > 00:10.0 Class 0c03: 1106:3038 (rev 80)
> > 00:10.1 Class 0c03: 1106:3038 (rev 80)
> > 00:10.2 Class 0c03: 1106:3038 (rev 80)
> > 00:10.3 Class 0c03: 1106:3104 (rev 82)
> 
> I get the same problem on an Intel laptop. Sometimes it works, sometimes it 
> doesn't. I'm in the process of tracking it down..

Folks, I've filed a bug at kernel bugzilla, so your reports won't be lost.
See http://bugme.osdl.org/show_bug.cgi?id=4817

You can register at http://bugme.osdl.org/createaccount.cgi and add yourself
to CC list.
