Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261286AbSJCOAa>; Thu, 3 Oct 2002 10:00:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261316AbSJCOAa>; Thu, 3 Oct 2002 10:00:30 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:23827 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S261286AbSJCOA3>; Thu, 3 Oct 2002 10:00:29 -0400
Date: Thu, 3 Oct 2002 15:05:31 +0100
From: John Levon <levon@movementarian.org>
To: linux-kernel@vger.kernel.org
Cc: kai-germaschewski@uiowa.edu
Subject: Re: RfC: Don't cd into subdirs during kbuild
Message-ID: <20021003140530.GA56233@compsoc.man.ac.uk>
References: <Pine.LNX.4.44.0210022153090.10307-100000@chaos.physics.uiowa.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0210022153090.10307-100000@chaos.physics.uiowa.edu>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan *17x6bb-0002Wl-00*1KWDVfljkZw* (Manchester Computing, University of Manchester)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2002 at 09:59:00PM -0500, Kai Germaschewski wrote:

> ChangeSet@1.676, 2002-10-02 14:42:00-05:00, kai@tp1.ruhr-uni-bochum.de
>   kbuild: Remove xfs vpath hack

Why is it a hack ?

>   xfs.o is built as one modules out of objects distributed into
>   multiple subdirs. That is okay with the current kbuild, you just
>   have to include the path for objects which reside in a subdir, then.
>   
>   xfs used vpath instead of explicitly adding the paths, which is
>   inconsistent and conflicts e.g. with proper module version generation.

So I must name the full path for each object in drivers/oprofile/ I
include from arch/i386/oprofile/ then ?

regards
john
