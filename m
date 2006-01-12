Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030458AbWALQVw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030458AbWALQVw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 11:21:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030460AbWALQVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 11:21:51 -0500
Received: from livid.absolutedigital.net ([66.92.46.173]:58570 "EHLO
	mx2.absolutedigital.net") by vger.kernel.org with ESMTP
	id S1030458AbWALQVv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 11:21:51 -0500
Date: Thu, 12 Jan 2006 11:21:51 -0500 (EST)
From: Cal Peake <cp@absolutedigital.net>
To: Sam Ravnborg <sam@ravnborg.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/11] kbuild: drop vmlinux dependency from "make install"
In-Reply-To: <11368427243850@foobar.com>
Message-ID: <Pine.LNX.4.61.0601121118550.6734@lancer.cnet.absolutedigital.net>
References: <11368427243850@foobar.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Jan 2006, Sam Ravnborg wrote:

> This removes the dependency from vmlinux to install, thus avoiding the
> current situation where "make install" has a nasty tendency to leave
> root-turds in the working directory.

Is removing the `kernel_install' target considered a userspace interface 
breakage? ;) Or am I just gonna have to get used to typing `make install' 
again?

-- 
"Silly rabbit, kicks are for ribs!" -- Homer Simpson

