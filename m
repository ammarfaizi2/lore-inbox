Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265100AbUGGMtk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265100AbUGGMtk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 08:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265102AbUGGMtk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 08:49:40 -0400
Received: from linuxhacker.ru ([217.76.32.60]:61142 "EHLO shrek.linuxhacker.ru")
	by vger.kernel.org with ESMTP id S265100AbUGGMta (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 08:49:30 -0400
Date: Wed, 7 Jul 2004 15:47:32 +0300
From: Oleg Drokin <green@clusterfs.com>
To: linux-kernel@vger.kernel.org, braam@clusterfs.com
Subject: [0/9] Lustre VFS patches for 2.6
Message-ID: <20040707124732.GA25877@clusterfs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   Following this mail, there are nine patches necessary for Lustre support
   in 2.6. The patches are against latest 2.6 bk snapshot.
   Compared to previous sets of patches, this one does not change existing
   structure and field names therefore leaving kernel VFS API completely intact.
   Also raw operations approach is changed, extra inode operation is introduced
   that is supposed to be called at the end of parent lookup and do necessary
   operations, if possible.
   Of course it would be great if these patches would be included into the
   kernel right away (and that is one of the reasons this set of patches
   keeps old API intact). Also there were at least some interest in some of the
   patches from other parties (e.g. Trond Myklebust was interested in some
   intent changes as I remember) and we are ready to work with those so that
   the patches will suit their needs as well.

Bye,
    Oleg
