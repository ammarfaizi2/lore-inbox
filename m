Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261677AbVDOAV1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261677AbVDOAV1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 20:21:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261682AbVDOATY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 20:19:24 -0400
Received: from mail.zmailer.org ([62.78.96.67]:8656 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id S261677AbVDOARv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 20:17:51 -0400
Date: Fri, 15 Apr 2005 03:17:47 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: abonilla <abonilla@linuxwireless.org>
Cc: Jesper Juhl <juhl-lkml@dif.dk>, linux-kernel@vger.kernel.org
Subject: Re: IBM Thinkpad T42 - Looking for a Developer.
Message-ID: <20050415001747.GO3858@mea-ext.zmailer.org>
References: <003901c54136$6ba545c0$9f0cc60a@amer.sykes.com> <Pine.LNX.4.62.0504142317480.3466@dragon.hyggekrogen.localhost> <20050414223641.M49815@linuxwireless.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050414223641.M49815@linuxwireless.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2005 at 06:40:16PM -0400, abonilla wrote:
> On Thu, 14 Apr 2005 23:20:19 +0200 (CEST), Jesper Juhl wrote
> > >  This is located in my home PC, Won't be the fastest downloads...
> > >  
> > >  http://wifitux.com/finger/
> > >  
> > Under what terms did you obtain these documents and from where? Are 
> > they completely freely distributable or are there strings attached?
> 
> I emailed the guys and they told me, "Hey, here you go, let me know if you
> want more information"

Those documents and files are downloadable also from   www.upek.com
They are rather scattered out there, but still...

In Linux environment we do need to define and implement our own
interface to the the device.  There is  BioAPI (www.bioapi.org)
interface specification, but that is rather high up in the application
stack.  (There exists also NIST written Linux version at that site,
and it seems to be "BSD with advertisement clause" licensed...)

My reading so far seems to indicate, that this is mostly doable
in the application space without needing kernel space drivers.

Implementing BioAPI interface library with device specific backends
(much in the same manner as SANE works) is the way, I do think.
To how large an extent the existing source code can be used
in this is so far unknown.

To be able to do the device specific backends, I do need to have
the detailed USB interface protocol descriptions, not just a windows
library binary wrapping them up into BioAPI.   I can handle NDA 
documents as long as the resulting source code into Linux (and any
other UNIX-like system capable to use it) can be published.

> > -- 
> > Jesper

/Matti Aarnio
