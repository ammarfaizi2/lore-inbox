Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751022AbVLTU0F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751022AbVLTU0F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 15:26:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751069AbVLTU0E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 15:26:04 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:40854 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751024AbVLTU0E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 15:26:04 -0500
Date: Tue, 20 Dec 2005 20:25:59 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Nix <nix@esperi.org.uk>
Cc: Sam Ravnborg <sam@ravnborg.org>,
       Linux-Kernel <linux-kernel@vger.kernel.org>,
       Linda Walsh <lkml@tlinx.org>
Subject: Re: Makefile targets: tar & rpm pkgs, while using O=<dir> as non-root
Message-ID: <20051220202559.GK27946@ftp.linux.org.uk>
References: <43A5F058.1060102@tlinx.org> <20051219071959.GJ13985@lug-owl.de> <87d5jru67j.fsf@amaterasu.srvr.nix> <20051220155839.GA9185@mars.ravnborg.org> <87irtjslxx.fsf@amaterasu.srvr.nix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87irtjslxx.fsf@amaterasu.srvr.nix>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2005 at 05:44:10PM +0000, Nix wrote:
> > 4) Builds for several architectures from same source base
> 
> cp -al
> 
> > 5) Builds for several different configurations
> 
> cp -al

... apply a patch and watch the resync hell.  That really, really doesn't
work well enough for use when doing any kind of development.
