Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280974AbRKGUYu>; Wed, 7 Nov 2001 15:24:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280971AbRKGUYl>; Wed, 7 Nov 2001 15:24:41 -0500
Received: from zero.tech9.net ([209.61.188.187]:16400 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S280952AbRKGUY2>;
	Wed, 7 Nov 2001 15:24:28 -0500
Subject: Re: ext3 vs resiserfs vs xfs
From: Robert Love <rml@tech9.net>
To: Ville Herva <vherva@niksula.hut.fi>
Cc: James A Sutherland <jas88@cam.ac.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <20011107213837.F26218@niksula.cs.hut.fi>
In-Reply-To: <E161UYR-0004S5-00@the-village.bc.nu>
	<E161Vbf-0000m9-00@lilac.csi.cam.ac.uk> 
	<20011107213837.F26218@niksula.cs.hut.fi>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.0+cvs.2001.11.06.15.04 (Preview Release)
Date: 07 Nov 2001 15:24:26 -0500
Message-Id: <1005164667.884.5.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2001-11-07 at 14:38, Ville Herva wrote:
> A stupid question: does ext3 replay the journal before fsck? If not, the
> inode errors would be expected...

ext3 will reply the root file systems journal on boot when the kernel
mounts root.  other ext3 partitions will have their journals replayed
when they are mounted.

also, btw, I use RedHat 7.2 and fsck does not run if I don't hit Y.  It
is there for pedants or seriously screwed disks -- the journal replay
should be sufficient.

	Robert Love




