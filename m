Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315282AbSHBPbU>; Fri, 2 Aug 2002 11:31:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315337AbSHBPbU>; Fri, 2 Aug 2002 11:31:20 -0400
Received: from ns.suse.de ([213.95.15.193]:49932 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S315282AbSHBPbU>;
	Fri, 2 Aug 2002 11:31:20 -0400
Date: Fri, 2 Aug 2002 17:34:49 +0200
From: Dave Jones <davej@suse.de>
To: gerg <gerg@snapgear.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: linux-2.5.30uc0 MMU-less patches
Message-ID: <20020802173449.N25761@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	gerg <gerg@snapgear.com>, linux-kernel@vger.kernel.org
References: <3D4A27FE.8030801@snapgear.com> <20020802141652.E25761@suse.de> <3D4AA573.3000705@snapgear.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3D4AA573.3000705@snapgear.com>; from gerg@snapgear.com on Sat, Aug 03, 2002 at 01:29:55AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 03, 2002 at 01:29:55AM +1000, gerg wrote:
 > Yep, there sure is some crap in there :-)
 > Obviously left over from the original copy out
 > from arch/i386/config.in.
 > 
 > I have cleaned all that silly stuff out for the
 > next patch.

With the silly nits like that aside, it leaves just the
more serious 'issues' such as those brought up by Willy
earlier.

The whole idea of a seperate mmnommu (or was it nommumm/ ?)
directory seemed a bit odd-looking too. (Asides from the
horrible name) I didn't check the code in detail, but
is there really that little that can be shared between
the regular mm/ ?

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
