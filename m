Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264535AbTFABMT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 21:12:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264536AbTFABMT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 21:12:19 -0400
Received: from waste.org ([209.173.204.2]:60053 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S264535AbTFABMS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 21:12:18 -0400
Date: Sat, 31 May 2003 20:25:16 -0500
From: Matt Mackall <mpm@selenic.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: J?rn Engel <joern@wohnheim.fh-wedel.de>,
       "David S. Miller" <davem@redhat.com>, jmorris@intercode.com.au,
       linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] 1/2 central workspace for zlib
Message-ID: <20030601012516.GJ23715@waste.org>
References: <20030530174319.GA16687@wohnheim.fh-wedel.de> <20030530.235505.23020750.davem@redhat.com> <20030531075615.GA25089@wohnheim.fh-wedel.de> <200305311822.21823.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305311822.21823.kernel@kolivas.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 31, 2003 at 06:22:21PM +1000, Con Kolivas wrote:
> 
> The only way I could think of was perhaps using a load on another disk 
> (io_other which is in contest) that is using jffs2 when the contest baseline 
> is running on a normal filesystem - this has shown very little differences 
> between filesystems normally. Otherwise if everything in contest is run on 
> jffs2 it would affect every layer and hard to be sure you had a control to 
> compare with.

Timing on jffs2 is notoriously unrepeatable anyway - it's fully log
structured rather than journalled so it behaves a little differently.

-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon
