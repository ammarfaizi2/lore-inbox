Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261356AbSJCUQe>; Thu, 3 Oct 2002 16:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261364AbSJCUQe>; Thu, 3 Oct 2002 16:16:34 -0400
Received: from surf.cadcamlab.org ([156.26.20.182]:59864 "EHLO
	surf.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S261356AbSJCUQd>; Thu, 3 Oct 2002 16:16:33 -0400
Date: Thu, 3 Oct 2002 15:20:55 -0500
To: Kai Germaschewski <kai-germaschewski@uiowa.edu>,
       kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: RfC: Don't cd into subdirs during kbuild
Message-ID: <20021003202055.GP1536@cadcamlab.org>
References: <Pine.LNX.4.44.0210022153090.10307-100000@chaos.physics.uiowa.edu> <20021003220120.B17403@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021003220120.B17403@mars.ravnborg.org>
User-Agent: Mutt/1.4i
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Sam Ravnborg]
> > +ifdef list-multi
> > +$(warning kbuild: list-multi ($(list-multi)) is obsolete in 2.5. Please fix!)
> > +endif
> Since kbuild no longer support list-multi this should be $(error ....)

Except that it is harmless.  list-multi is a hint which the kbuild
system no longer needs.  Code with list-multi is (I believe) still
compatible with today's kbuild, so there's no need to *force* a
cleanup.

Peter
