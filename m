Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262445AbVGFS6w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262445AbVGFS6w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 14:58:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261921AbVGFSyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 14:54:46 -0400
Received: from mail26.bluewin.ch ([195.186.19.68]:33523 "EHLO
	mail26.bluewin.ch") by vger.kernel.org with ESMTP id S262025AbVGFNqa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 09:46:30 -0400
Date: Wed, 6 Jul 2005 15:43:49 +0200
From: Adrian Ulrich <reiser4@blinkenlights.ch>
To: David Masover <ninja@slaphack.com>
Cc: reiser@namesys.com, hubert@uhoreg.ca, agmsmith@rogers.com,
       ross.biro@gmail.com, vonbrand@inf.utfsm.cl, mrmacman_g4@mac.com,
       Valdis.Kletnieks@vt.edu, ltd@cisco.com, gmaxwell@gmail.com,
       jgarzik@pobox.com, hch@infradead.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, reiserfs-list@namesys.com,
       zam@namesys.com, vs@thebsh.namesys.com, ndiller@namesys.com,
       vitaly@thebsh.namesys.com
Subject: Re: reiser4 plugins
Message-Id: <20050706154349.5d6aa92c.reiser4@blinkenlights.ch>
In-Reply-To: <42CBD7F6.2050203@slaphack.com>
References: <42CB1E12.2090005@namesys.com>
	<1740726161-BeMail@cr593174-a>
	<87hdf8zqca.fsf@evinrude.uhoreg.ca>
	<42CB7DE0.4050200@namesys.com>
	<42CBD7F6.2050203@slaphack.com>
Organization: Bluewin AG
X-Mailer: Sylpheed version 2.0.0beta2 (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> so all we have left is the issue of whether using /meta costs us 
> performance, or whether breaking POSIX to add a symlink (such as 
> foo/...) really gives us that much more usability.

IMHO '/meta' isn't such a good idea, because a chrooted application
won't be able to use it.

