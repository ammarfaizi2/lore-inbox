Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263234AbUKTX4F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263234AbUKTX4F (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 18:56:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261528AbUKTXpX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 18:45:23 -0500
Received: from dp.samba.org ([66.70.73.150]:33664 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263209AbUKTXaY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 18:30:24 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16799.54105.309518.787330@samba.org>
Date: Sun, 21 Nov 2004 10:29:29 +1100
To: Hans Reiser <reiser@namesys.com>
Cc: Anton Altaparmakov <aia21@cam.ac.uk>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: performance of filesystem xattrs with Samba4
In-Reply-To: <419F6EB9.4020207@namesys.com>
References: <16797.41728.984065.479474@samba.org>
	<1100865833.6443.17.camel@imp.csi.cam.ac.uk>
	<16797.60034.186288.663343@samba.org>
	<Pine.LNX.4.60.0411191352050.8634@hermes-1.csi.cam.ac.uk>
	<16799.8212.96811.520317@samba.org>
	<419F6EB9.4020207@namesys.com>
X-Mailer: VM 7.19 under Emacs 21.3.1
Reply-To: tridge@samba.org
From: tridge@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans,

 > There are still bugs with it that have us turning it off for now, but I 
 > think we will fix those in the next year.

Do you plan to add user xattr support before then? 

The reason I ask is that without either xattr support or named streams
Samba4 has no way to store the additional file meta data it needs.

Maybe xattr support could be a reiser4 plugin?

Cheers, Tridge
