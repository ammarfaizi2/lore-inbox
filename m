Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135943AbRDTRWX>; Fri, 20 Apr 2001 13:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135976AbRDTRWN>; Fri, 20 Apr 2001 13:22:13 -0400
Received: from elektra.higherplane.net ([203.37.52.137]:2235 "EHLO
	elektra.higherplane.net") by vger.kernel.org with ESMTP
	id <S135943AbRDTRWI>; Fri, 20 Apr 2001 13:22:08 -0400
Date: Sat, 21 Apr 2001 03:30:19 +1000
From: john slee <indigoid@higherplane.net>
To: Harald Welte <laforge@gnumonks.org>
Cc: Jonathan Lundell <jlundell@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: Documentation of module parameters.
Message-ID: <20010421033019.N10345@higherplane.net>
In-Reply-To: <3ADBB8C9.CC7FD941@nc.rr.com> <p05100b07b7017fc83c2e@[207.213.214.34]> <20010420133722.D2461@tatooine.laforge.distro.conectiva> <20010421031920.M10345@higherplane.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="n/aVsWSeQ4JHkrmm"
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010421031920.M10345@higherplane.net>; from indigoid@higherplane.net on Sat, Apr 21, 2001 at 03:19:20AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--n/aVsWSeQ4JHkrmm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Apr 21, 2001 at 03:19:20AM +1000, john slee wrote:
> it sounded like a challenge.  this might help someone who can't be

and it might be even more helpful if it didnt appear with a stupid
mimetype.

attempt #2

-- 
"Bobby, jiggle Grandpa's rat so it looks alive, please" -- gary larson

--n/aVsWSeQ4JHkrmm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="kernel-module-info.sh"

#!/bin/sh

# john slee <indigoid@higherplane.net>
# Sat Apr 21 03:17:55 EST 2001
# quick and dirty.  run from a kernel source dir somewhere.

find . -name "*.c" | xargs egrep 'MODULE_DESCRIPTION|MODULE_PARM_DESC' \
	| sed '/#undef/d; s/^\.\///; s/[:()]/	/g; s/[";]//g; /MODULE_PARM_DESC/s/,[ ]*/	/; /^[	 ]*$/d'

--n/aVsWSeQ4JHkrmm--
