Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269617AbTGXRhN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 13:37:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269621AbTGXRhN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 13:37:13 -0400
Received: from tomts23-srv.bellnexxia.net ([209.226.175.185]:11677 "EHLO
	tomts23-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S269617AbTGXRhI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 13:37:08 -0400
Date: Thu, 24 Jul 2003 13:50:48 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Diego Calleja =?ISO-8859-15?Q?Garc=EDa?= <diegocg@teleline.es>
cc: Bas Mevissen <ml@basmevissen.nl>, linux-kernel@vger.kernel.org
Subject: Re: time for some drivers to be removed?
In-Reply-To: <20030724193211.39d7ed68.diegocg@teleline.es>
Message-ID: <Pine.LNX.4.53.0307241346490.20950@localhost.localdomain>
References: <Pine.LNX.4.53.0307240817520.19533@localhost.localdomain>
 <1059058737.7994.25.camel@dhcp22.swansea.linux.org.uk> <3F1FFC94.7080409@basmevissen.nl>
 <20030724193211.39d7ed68.diegocg@teleline.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jul 2003, Diego Calleja [ISO-8859-15] García wrote:

> El Thu, 24 Jul 2003 17:34:44 +0200 Bas Mevissen <ml@basmevissen.nl> escribió:
> 
> > This would make a reasonable Q-requirement for 2.6.0 that at least the 
> > kernel compiles with 'make allyesconfig'. The only thing open is to 
> 
> That 2.6.0 builds with 'make allyesconfig' or not is irrelevant.
> Moving broken drivers to a dark place doesn't fix them  nor increase the
> "quality" level.....

once upon a time, i suggested having more than one level of module
"quality".  at the moment, some kernel code is marked as "EXPERIMENTAL",
but this is supported via a regular dependency when it doesn't really
qualify as a dependency.  dependencies are typically used to refer to
dependencies on other *code*, not some abstract level of goodness
like "EXPERIMENTAL".

perhaps it's time to add another category with values like OBSOLETE,
DEPRECATED, EXPERIMENTAL, BROKEN(?) and so on.  by default, the
quality would be regular, or something like that.

and in the end, while i know some folks don't think it's a big
deal, i think doing a "make allyesconfig" really should work.

rday
