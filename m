Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269083AbTCBCNR>; Sat, 1 Mar 2003 21:13:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269084AbTCBCNR>; Sat, 1 Mar 2003 21:13:17 -0500
Received: from h-64-105-35-98.SNVACAID.covad.net ([64.105.35.98]:7050 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S269083AbTCBCNQ>; Sat, 1 Mar 2003 21:13:16 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sat, 1 Mar 2003 18:23:21 -0800
Message-Id: <200303020223.SAA13660@adam.yggdrasil.com>
To: diegocg@teleline.es
Subject: Re: BitBucket: GPL-ed KitBeeper clone
Cc: andrea@suse.de, hch@infradead.org, linux-kernel@vger.kernel.org,
       pavel@janik.cz, pavel@ucw.cz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arador <diegocg@teleline.es> wrote:
>Why to waste time trying to clone a 
>tool such as bitkeeper? Why not to support things like subversion?

	"Why" depends on one's priorities.

	Some of us the linux-kernel crowd are interested in being able
to interface with the bitkeeper-using kernel developers a bit more
efficiently.  The developers currently using bitkeeper started using
it when these other systems were already available, so I doubt that
improving another free version control system will do more for free
software adoption than providing BK compatability (I don't know if
that is a priority for you).

	Note that Subversion, in particular, is GPL incompatible and
uses its own underlying repository format that isn't particularly
compatible with anything else and required a web server plus some
minor web server extension when last I checked.  As I previously
mentioned, Bitkeeper is based on sccs for which a GPL-compatible clone
exists: cssc, and sccs format is used in a lot of other places as
well.  So the result of cloning the "uber-cvs" in bitkeeper might
actually have more applicability than trying to extract the same layer
from subversion, even though Subversion is freer than BitKeeper.

	Different people have different priorities or order them
differently.  If you contribute to aegis, prcs, or even Subversion, I
think that's great.  If you produce a separate GPL compatible
"uber-CVS" layer that way, I would be interested in hearing about it.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
