Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291307AbSBGVFE>; Thu, 7 Feb 2002 16:05:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291308AbSBGVEu>; Thu, 7 Feb 2002 16:04:50 -0500
Received: from dsl-213-023-038-235.arcor-ip.net ([213.23.38.235]:58257 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S291307AbSBGVE3>;
	Thu, 7 Feb 2002 16:04:29 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Mike Touloumtzis <miket@bluemug.com>
Subject: Re: How to check the kernel compile options ?
Date: Thu, 7 Feb 2002 22:08:44 +0100
X-Mailer: KMail [version 1.3.2]
Cc: "H. Peter Anvin" <hpa@zytor.com>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
        linux-kernel@vger.kernel.org
In-Reply-To: <a3mjhc$qba$1@cesium.transmeta.com> <E16Yu52-00015I-00@starship.berlin> <20020207203451.GE26826@bluemug.com>
In-Reply-To: <20020207203451.GE26826@bluemug.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16Yvmf-00015n-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 7, 2002 09:34 pm, Mike Touloumtzis wrote:
> A final argument for using packaging/bundling tools and userspace files
> instead of files in /proc for tracking kernel metadata:
> 
> -- Kernels are no longer single files, at least for most people.
>    A _harder_ problem than this one is tracking which modules go with
>    which kernel.  Solving this problem solves the configuration tracking
>    problem as a _side_effect_.  Conversely, solving the configuration
>    tracking problem without solving the module tracking problem is
>    largely useless.

I can always rebuild the modules from a standard source tree, given the 
config.  This makes the config a far more important piece of data than the 
modules themselves, and that is why I want it stuck right on the side of the 
kernel, the way my memory sticks have a little sticker on them telling me 
what I've got.

As an option of course, you're welcome to build your kernel without it, and 
you can also peel the stickers off your memory sticks and file them in a 
drawer if you like.

-- 
Daniel
