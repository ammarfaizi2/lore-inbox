Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261648AbVBOILl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261648AbVBOILl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 03:11:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261649AbVBOILl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 03:11:41 -0500
Received: from [83.102.214.158] ([83.102.214.158]:21463 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S261648AbVBOILj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 03:11:39 -0500
X-Comment-To: Sonny Rao
To: Sonny Rao <sonny@burdell.org>
Cc: Alex Tomas <alex@clusterfs.com>, Mingming Cao <cmm@us.ibm.com>,
       Andreas Dilger <adilger@clusterfs.com>, Andrew Morton <akpm@osdl.org>,
       tytso@mit.edu, pbadari@us.ibm.com, suparna@in.ibm.com,
       gerrit@us.ibm.com, tappro@clusterfs.com,
       linux-kernel <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] Re: Latest ext3 patches (extents, mballoc, delayed
 allocation)
References: <1106354192.3634.19.camel@dyn318043bld.beaverton.ibm.com>
	<m3hdl2lehb.fsf@bzzz.home.net> <4207BBEA.7090705@us.ibm.com>
	<m3y8dude4q.fsf@bzzz.home.net>
	<20050215074539.GA12576@kevlar.burdell.org>
From: Alex Tomas <alex@clusterfs.com>
Organization: HOME
Date: Tue, 15 Feb 2005 11:08:58 +0300
In-Reply-To: <20050215074539.GA12576@kevlar.burdell.org> (Sonny Rao's
 message of "Tue, 15 Feb 2005 02:45:39 -0500")
Message-ID: <m3vf8ui6sl.fsf@bzzz.home.net>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Sonny Rao (SR) writes:

 SR> Alex, small buglet, If the FIBMAP-ioctl get's called on a file with
 SR> delayed allocation, you need to flush it (or at least allocate) before
 SR> returning the mappings.   This doesn't seem to work properly at
 SR> present.  

good catch. thanks. 

