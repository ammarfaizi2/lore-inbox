Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317766AbSFSE6Y>; Wed, 19 Jun 2002 00:58:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317767AbSFSE6X>; Wed, 19 Jun 2002 00:58:23 -0400
Received: from ns.suse.de ([213.95.15.193]:32273 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S317766AbSFSE6X>;
	Wed, 19 Jun 2002 00:58:23 -0400
Date: Wed, 19 Jun 2002 06:58:24 +0200
From: Dave Jones <davej@suse.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.x: arch/i386/kernel/cpu
Message-ID: <20020619065823.C25509@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
References: <aeouoe$a66$1@cesium.transmeta.com> <20020619063807.B25509@suse.de> <3D100BE7.4040802@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3D100BE7.4040802@zytor.com>; from hpa@zytor.com on Tue, Jun 18, 2002 at 09:43:19PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2002 at 09:43:19PM -0700, H. Peter Anvin wrote:

 > > Patrick Mochel takes credit/glory/fame/blame for this one.
 > Note that this is great.  We should do the same with bugs.h which is, if 
 > anything, an even worse mess.

Agreed. Patrick also did similar work on the mtrr driver which isn't
merged anywhere yet. That's something else that's been long overdue
this treatment.  (Also on my list for chopping into bits is
agpgart_be.c, but that's another story..)

 > > On my Cyrix III box before..
 > > Interesting how it's picking up that 8 in the 2nd set of caps, but
 > > not any of the other bits..
 > 
 > That's the 3DNow! bit... I was thinking it might be handled specially, 
 > but it looks like that's only done for Centaur chips.  Are you sure your 
 > CPU isn't being mis-identified as Centaur by the new code?

It is being (correctly) identified as Centaur.
VIA Cyrixen are CentaurHauls family 6

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
