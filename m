Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284870AbRLFAIi>; Wed, 5 Dec 2001 19:08:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284873AbRLFAI3>; Wed, 5 Dec 2001 19:08:29 -0500
Received: from peace.netnation.com ([204.174.223.2]:4069 "EHLO
	peace.netnation.com") by vger.kernel.org with ESMTP
	id <S284870AbRLFAIR>; Wed, 5 Dec 2001 19:08:17 -0500
Date: Wed, 5 Dec 2001 16:08:16 -0800
From: Simon Kirby <sim@netnation.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [FS] Why doesn't this patch work?
Message-ID: <20011205160816.A26214@netnation.com>
In-Reply-To: <20011205152834.A11289@netnation.com> <1007595982.848.4.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <1007595982.848.4.camel@phantasy>; from rml@tech9.net on Wed, Dec 05, 2001 at 06:46:21PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2001 at 06:46:21PM -0500, Robert Love wrote:

> On Wed, 2001-12-05 at 18:28, Simon Kirby wrote:
> > I'm attempting to write this little dinky patch to see who calls fsync()
> > or fdatasync(), but it's spitting out compiler warnings.  I can't figure
> > out why, though.  What did I do wrong?
> > 
> > buffer.c: In function `report_culprit':
> > buffer.c:409: warning: assignment from incompatible pointer type
> > buffer.c:410: warning: passing arg 2 of `d_path' from incompatible pointer type
> > buffer.c:420: warning: passing arg 1 of `mntput' from incompatible pointer type
> 
> s/struct vfsmnt/struct vfsmount/

Doh!

Simon-

[  Stormix Technologies Inc.  ][  NetNation Communications Inc. ]
[       sim@stormix.com       ][       sim@netnation.com        ]
[ Opinions expressed are not necessarily those of my employers. ]
