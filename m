Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932160AbWAQSKj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932160AbWAQSKj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 13:10:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932257AbWAQSKi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 13:10:38 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:52488 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932160AbWAQSK3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 13:10:29 -0500
Date: Tue, 17 Jan 2006 19:10:12 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Ryan Anderson <ryan@michonline.com>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Junio C Hamano <junkio@cox.net>,
       git@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: git-diff-files and fakeroot
Message-ID: <20060117181012.GA8047@mars.ravnborg.org>
References: <43CC5231.3090005@michonline.com> <7vzmlvk2bs.fsf@assigned-by-dhcp.cox.net> <20060117052758.GA22839@mythryan2.michonline.com> <95E085A7-B910-4C01-BA6E-43971A6F5F97@mac.com> <43CC89F0.7060109@michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43CC89F0.7060109@michonline.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2006 at 01:08:48AM -0500, Ryan Anderson wrote:
> 
> I think I might take your suggestion, and fix up the builddeb script to
> do the "run as root" part itself, rather than needing to do it outside. 
> It would make it possible to just run "make oldconfig deb-pkg" which
> would make things a little bit simpler.
If we do something it must be consistent for all *-pkg targets.
So fixing up builddeb is not enough, we must fix it for rpm etc also.

Not that I have looked into what is needed, but we shall not have
inconsistent behavious between the different *-pkg targets.

	Sam
