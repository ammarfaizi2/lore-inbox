Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751121AbVLTQ3x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751121AbVLTQ3x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 11:29:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751122AbVLTQ3x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 11:29:53 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:2665 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S1751121AbVLTQ3x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 11:29:53 -0500
Date: Tue, 20 Dec 2005 16:58:39 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Nix <nix@esperi.org.uk>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>, Linda Walsh <lkml@tlinx.org>
Subject: Re: Makefile targets: tar & rpm pkgs, while using O=<dir> as non-root
Message-ID: <20051220155839.GA9185@mars.ravnborg.org>
References: <43A5F058.1060102@tlinx.org> <20051219071959.GJ13985@lug-owl.de> <87d5jru67j.fsf@amaterasu.srvr.nix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d5jru67j.fsf@amaterasu.srvr.nix>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2005 at 03:41:04PM +0000, Nix wrote:
> but for normal software? What's the point?)
> 
> I mean, instead of
> 
> cd linux-2.6.blah
> make blah O=/some/directory
> 
> you can always do
> 
> cp -al linux-2.6.blah /some/directory/
> cd /some/directory
> make blah

Consider following use cases:
1) Src located on NFS mounted filesystem
2) Src on RO media
3) Src on another filesystem
4) Builds for several architectures from same source base
5) Builds for several different configurations
etc.

It is convinient in many places. Maybe not for you but for others.

	Sam
