Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267281AbSKSUoa>; Tue, 19 Nov 2002 15:44:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267320AbSKSUoN>; Tue, 19 Nov 2002 15:44:13 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:34977 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S267281AbSKSUnV>; Tue, 19 Nov 2002 15:43:21 -0500
Date: Tue, 19 Nov 2002 14:50:13 -0600 (CST)
From: Kai Germaschewski <kai-germaschewski@uiowa.edu>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Sam Ravnborg <sam@ravnborg.org>, <linux-kernel@vger.kernel.org>,
       <kbuild-devel@lists.sourceforge.net>
Subject: Re: [RFC/CFT] Separate obj/src dir
In-Reply-To: <Pine.LNX.3.95.1021119153545.6004A-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.4.44.0211191448370.24137-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Nov 2002, Richard B. Johnson wrote:

> I think all you did was increase the compile time by writing
> output files to different directories than the ones currently
> in cache. There are a lot of negatives. It would be a shame for
> you to waste a great deal of time on something that would not
> be accepted into the distribution. Remember the earlier `make modules`
> where the new objects went into a separate directory with sym-links?
> That got changed. I think it got changed for good reasons.

Well, this isn't necessarily for everybody, if it's of no use for you, 
that's okay. Note that the patch doesn't (unless it has bugs ;) change the 
normal behavior at all. It really only adds a script to set up a separate 
objdir. If you don't want that, don't use that script ;)

--Kai


