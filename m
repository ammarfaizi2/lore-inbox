Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932316AbWCCQmn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932316AbWCCQmn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 11:42:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932320AbWCCQmn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 11:42:43 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:26376 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932316AbWCCQmm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 11:42:42 -0500
Date: Fri, 3 Mar 2006 17:42:21 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Andrew Haninger <ahaning@gmail.com>
Cc: tim tim <tictactoe.tim@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: modutils
Message-ID: <20060303164221.GA10302@mars.ravnborg.org>
References: <503e0f9d0603022041q717ae7cdo8539ba8f508dd681@mail.gmail.com> <105c793f0603022138u6dca326ewa3b5d476f4c4ef48@mail.gmail.com> <503e0f9d0603022141l5dc9a88ds380dd9dd2ba22c41@mail.gmail.com> <105c793f0603022145t55f25cedpd6c40efd703530f5@mail.gmail.com> <503e0f9d0603022155j2570314jffcdf84060e336f2@mail.gmail.com> <105c793f0603022205j124a9d19qab33c34e9750d5c9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <105c793f0603022205j124a9d19qab33c34e9750d5c9@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 03, 2006 at 01:05:19AM -0500, Andrew Haninger wrote:
> On 3/3/06, tim tim <tictactoe.tim@gmail.com> wrote:
> > here i am trying to install 2.6.10 kernel on the system that was fully
> > installed RedHat EL3 (2.4.21). we followed this procedure..
Hi Tim tim.

The warnings you see is a module that references symbols that it cannot
resolve.
Do you have a vmlinux in the root of your kernel tree?
Does Module.symvers include the symbols that you get warnings on?

You need to do a successfully build of the kernel before you can build
the modules.

	Sam
