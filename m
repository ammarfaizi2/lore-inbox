Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262287AbVBBQih@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262287AbVBBQih (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 11:38:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262586AbVBBQfQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 11:35:16 -0500
Received: from rproxy.gmail.com ([64.233.170.200]:10335 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262508AbVBBQZj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 11:25:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=uC4TkaNWmHlN3Qj6qFVrTzowgV6zpUhnXpVaOxTk4nIStB+OktFV5v2ixutmbsTUCh5Xps/SDT6NyyZKDnqe8JEHS2XpG4H999H9pC/SZnHyNEpV4gaZoP1SUGRkY+jakE1PGOPDh96paygVNKfnn3wlFbdgQ5vW3Kquwq8qOl4=
Message-ID: <9e4733910502020825434a477@mail.gmail.com>
Date: Wed, 2 Feb 2005 11:25:29 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Accelerated frame buffer functions
In-Reply-To: <20050202154139.GA3267@s>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050202133108.GA2410@s>
	 <Pine.LNX.4.61.0502020900080.16140@chaos.analogic.com>
	 <20050202142155.GA2764@s> <1107357093.6191.53.camel@gonzales>
	 <20050202154139.GA3267@s>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Feb 2005 16:41:39 +0100, Haakon Riiser
<haakon.riiser@fys.uio.no> wrote:
> Thanks for the tip, I hadn't heard about it.  I will take a look,
> but only to see if it can show me the user space API of /dev/fb.
> I don't need a general library that supports a bunch of different
> graphics cards.  I'm writing my own frame buffer driver for the
> GX2 CPU, and I just want to know how to call the various functions
> registered in struct fb_ops, so that I can test my code.  I mean,
> all those functions registered in fb_ops must be accessible
> somehow; if they weren't, what purpose would they serve?

You should look at writing a DRM driver. DRM implements the kernel
interface to get 3D hardware running. It is a fully accelerated driver
interface. They are located in drivers/char/drm

-- 
Jon Smirl
jonsmirl@gmail.com
