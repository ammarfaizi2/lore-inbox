Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261808AbVAIVSY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261808AbVAIVSY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 16:18:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261812AbVAIVSY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 16:18:24 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:60780 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261808AbVAIVR2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 16:17:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=opqEERx5YJGDXL1SoHC20+aGDm1Dg3ZCZb9kuNC3F2UFsF97ArkjPUXxr2Mzb4RAGHANw0h/Q3rSwbrnhiX4wMB+Ykelj+xQnAEQ7F36aFDxFDxcy2Z2JvOHuxPauVMUrrM31brsdqgZYV8nSQ+HHWkOlkWq+shlh1n9MR2zZm0=
Message-ID: <8b12046a0501091317384707b@mail.gmail.com>
Date: Sun, 9 Jan 2005 21:17:27 +0000
From: Subodh Shrivastava <subodh.shrivastava@gmail.com>
Reply-To: Subodh Shrivastava <subodh.shrivastava@gmail.com>
To: Benoit Boissinot <bboissin@gmail.com>
Subject: Re: 2.6.10-mm2 frame buffer does not works with X
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <40f323d0050109125257b88f0c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <8b12046a050109123670cda02c@mail.gmail.com>
	 <40f323d0050109125257b88f0c@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The below mentioned patch solves the problem for me.

Many Thanks


On Sun, 9 Jan 2005 21:52:28 +0100, Benoit Boissinot <bboissin@gmail.com> wrote:
> On Sun, 9 Jan 2005 20:36:04 +0000, Subodh Shrivastava
> <subodh.shrivastava@gmail.com> wrote:
> > Hi Andrew,
> >
> > X server with frame buffer does not works. I am using following option
> > in my xorg.conf.
> >
> > Option      "UseFBDev" "on"
> >
> > I am attaching the dmesg, lspci -v and .config files. Also i have
> > tested 2.6.10 and it works fine. Last mm series which works fine is
> > "2.6.10-rc2-mm4".
> >
> > --
> > Subodh
> >
> >
> >
> this patch should solve your problem :
> http://marc.theaimsgroup.com/?l=linux-kernel&m=110504486230527&w=2
> 


-- 
Subodh
