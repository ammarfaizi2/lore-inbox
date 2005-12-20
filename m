Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750744AbVLTRp1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750744AbVLTRp1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 12:45:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750749AbVLTRp1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 12:45:27 -0500
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:61448 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S1750744AbVLTRp0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 12:45:26 -0500
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>, Linda Walsh <lkml@tlinx.org>
Subject: Re: Makefile targets: tar & rpm pkgs, while using O=<dir> as
 non-root
References: <43A5F058.1060102@tlinx.org> <20051219071959.GJ13985@lug-owl.de>
	<87d5jru67j.fsf@amaterasu.srvr.nix>
	<20051220155839.GA9185@mars.ravnborg.org>
From: Nix <nix@esperi.org.uk>
X-Emacs: because Hell was full.
Date: Tue, 20 Dec 2005 17:44:10 +0000
In-Reply-To: <20051220155839.GA9185@mars.ravnborg.org> (Sam Ravnborg's
 message of "Tue, 20 Dec 2005 16:58:39 +0100")
Message-ID: <87irtjslxx.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Dec 2005, Sam Ravnborg said:
> Consider following use cases:
> 1) Src located on NFS mounted filesystem

Nothing wrong with that. NFS is fast for me.

(Admittedly, on heavily contended networks you're right.)

> 2) Src on RO media

*Good* reason (one that unionfs would solve, but still...)

> 4) Builds for several architectures from same source base

cp -al

> 5) Builds for several different configurations

cp -al

> It is convinient in many places. Maybe not for you but for others.

There were a couple of compelling arguments in there. :)

-- 
`I must caution that dipping fingers into molten lead
 presents several serious dangers.' --- Jearl Walker
