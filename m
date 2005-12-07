Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751202AbVLGQeM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbVLGQeM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 11:34:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751201AbVLGQeL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 11:34:11 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:13512 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751202AbVLGQeK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 11:34:10 -0500
Subject: RE: stat64 for over 2TB file returned invalid st_blocks
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Takashi Sato <sho@tnes.nec.co.jp>,
       "'Andreas Dilger'" <adilger@clusterfs.com>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <1133969671.27373.47.camel@lade.trondhjem.org>
References: <000001c5fb1d$0a27c8d0$4168010a@bsd.tnes.nec.co.jp>
	 <1133963528.27373.4.camel@lade.trondhjem.org>
	 <1133967716.8910.5.camel@kleikamp.austin.ibm.com>
	 <1133969671.27373.47.camel@lade.trondhjem.org>
Content-Type: text/plain
Date: Wed, 07 Dec 2005 10:34:07 -0600
Message-Id: <1133973247.8907.33.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-12-07 at 10:34 -0500, Trond Myklebust wrote:
> If you really want a variable size type here, then the right thing to do
> is to define a __kernel_blkcnt_t or some such thing, and hide the
> configuration knob for it somewhere in the arch-specific Kconfigs.

Takashi's patch does improve on what currently exists.  Maybe someone
can create a separate patch to replace sector_t with blkcnt_t where it
makes sense.
-- 
David Kleikamp
IBM Linux Technology Center

