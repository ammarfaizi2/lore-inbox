Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751098AbWFXVSj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751098AbWFXVSj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 17:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751106AbWFXVSj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 17:18:39 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:43684 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751101AbWFXVSj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 17:18:39 -0400
Date: Sat, 24 Jun 2006 23:18:38 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add option for stripping modules while installing them
Message-ID: <20060624211838.GD2049@mars.ravnborg.org>
References: <E1FtDRV-0003yL-Ta@candygram.thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1FtDRV-0003yL-Ta@candygram.thunk.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2006 at 08:53:09PM -0400, Theodore Ts'o wrote:
> 
> [ I sent this to kbuild-devel@lists.sourceforge.net cc'ed to LKML about
>   two weeks ago, and never got a comment.  Andrew could you include this
>   in the -mm tree?   It's IMHO a useful feature.  -- Ted ]

Saw it then but never came back due to limited hacking time at the
moment. I've replaced the direct call to strip with $(STRIP),
since we may be installing on a root filesystem for another
architecture.

	Sam
