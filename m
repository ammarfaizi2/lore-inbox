Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932688AbVINIi1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932688AbVINIi1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 04:38:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932694AbVINIi1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 04:38:27 -0400
Received: from livid.absolutedigital.net ([66.92.46.173]:29847 "EHLO
	mx2.absolutedigital.net") by vger.kernel.org with ESMTP
	id S932688AbVINIi0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 04:38:26 -0400
Date: Wed, 14 Sep 2005 04:38:07 -0400 (EDT)
From: Cal Peake <cp@absolutedigital.net>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org, paolo.ciarrocchi@gmail.com,
       paultt@bilug.linux.it, rdunlap@xenotime.net, jesper.juhl@gmail.com
Subject: Re: [PATCH] 2.6.13-mm3 ort v.b6 (OOPS Reporting Tool), try2
In-Reply-To: <43276366.80304@gmail.com>
Message-ID: <Pine.LNX.4.61.0509140436090.4846@lancer.cnet.absolutedigital.net>
References: <43276366.80304@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Sep 2005, Michal Piotrowski wrote:

> Hi Andrew,
> I think, that this maybe useful for oops hunters :)
> 
> Paolo, Paul, Randy, Jesper, Cal please sign it.
> 
> Regards,
> Michal Piotrowski
> 
> Signed-off-by: Michal K. K. Piotrowski <michal.k.k.piotrowski@gmail.com>

Signed-off-by: Cal Peake <cp@absolutedigital.net>

> diff -uprN -X linux-mm-clean/Documentation/dontdiff
> linux-mm-clean/scripts/ort.sh linux-mm/scripts/ort.sh
> --- linux-mm-clean/scripts/ort.sh    1970-01-01 01:00:00.000000000 +0100
> +++ linux-mm/scripts/ort.sh    2005-09-14 01:21:01.000000000 +0200
> @@ -0,0 +1,1089 @@
> +#!/bin/sh
> +
> +# Copyright (C) 2005  Michal Piotrowski <piotrowskim@trex.wsi.edu.pl>
> +#                                       <michal.k.k.piotrowski@gmail.com>
> +# Copyright (C) 2005  Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
> +# Copyright (C) 2005  Paul TT <paultt@bilug.linux.it>
> +# Copyright (C) 2005  Randy Dunlap <rdunlap@xenotime.net>
> +# Copyright (C) 2005  Jesper Juhl <jesper.juhl@gmail.com>
> +# Copyright (C) 2005  Cal Peake <cp@absolutedigital.net>
> +#
> +# This program is free software; you can redistribute it and/or modify
> +# it under the terms of the GNU General Public License as published by
> +# the Free Software Foundation; either version 2 of the License, or
> +# (at your option) any later version.
> +#
> +# This program is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program; if not, write to the Free Software
> +# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

-- 
". . . tell 'em we use Linux." -- Dave Chappelle

