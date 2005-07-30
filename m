Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263098AbVG3SNm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263098AbVG3SNm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 14:13:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263097AbVG3SNl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 14:13:41 -0400
Received: from fsmlabs.com ([168.103.115.128]:54248 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S263095AbVG3SM3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 14:12:29 -0400
Date: Sat, 30 Jul 2005 12:18:01 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Lee Revell <rlrevell@joe-job.com>
cc: Marc Ballarin <Ballarin.Marc@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: Power consumption HZ100, HZ250, HZ1000: new numbers
In-Reply-To: <1122746718.14769.4.camel@mindpipe>
Message-ID: <Pine.LNX.4.61.0507301216370.29844@montezuma.fsmlabs.com>
References: <20050730004924.087a7630.Ballarin.Marc@gmx.de> 
 <1122678943.9381.44.camel@mindpipe>  <20050730120645.77a33a34.Ballarin.Marc@gmx.de>
 <1122746718.14769.4.camel@mindpipe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Jul 2005, Lee Revell wrote:

> So it looks like artsd wastes way more power DMAing a bunch of silent
> pages to the sound card than HZ=1000.
> 
> There's nothing the ALSA layer can do about this, it's a KDE bug.
> 
> I think this is a good argument for leaving HZ at 1000 until some of
> these userspace bugs are fixed.

It's already 'fixed' just set artsd to release the sound device after some 
idle time. It's in the "Auto-Suspend" seection of the KDE sound system 
control module.
