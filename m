Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318248AbSGQLoQ>; Wed, 17 Jul 2002 07:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318266AbSGQLoQ>; Wed, 17 Jul 2002 07:44:16 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:23815 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S318248AbSGQLoO>; Wed, 17 Jul 2002 07:44:14 -0400
Date: Wed, 17 Jul 2002 13:47:09 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Ext3 vs Reiserfs benchmarks
Message-ID: <20020717114708.GC28284@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20020716193831.GC22053@merlin.emma.line.org> <Pine.LNX.4.44.0207161408270.3452-100000@hawkeye.luckynet.adm> <20020716210639.GC30235@merlin.emma.line.org> <20020716212322.GT442@clusterfs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020716212322.GT442@clusterfs.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jul 2002, Andreas Dilger wrote:

> This is all done already for both LVM and EVMS snapshots.  The filesystem
> (ext3, reiserfs, XFS, JFS) flushes the outstanding operations and is
> frozen, the snapshot is created, and the filesystem becomes active again.
> It takes a second or less.  Then dump will guarantee 100% correct backups
> of the snapshot filesystem.  You would have to do a backup on the snapshot
> to guarantee 100% correctness even with tar.

Sure. On some machines, they will go with dsmc anyhow which reads the
file and rereads if it changes under dsmc's hands.

-- 
Matthias Andree
