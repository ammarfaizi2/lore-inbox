Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264034AbUDBMs0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 07:48:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264035AbUDBMs0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 07:48:26 -0500
Received: from fed1mtao08.cox.net ([68.6.19.123]:12990 "EHLO
	fed1mtao08.cox.net") by vger.kernel.org with ESMTP id S264034AbUDBMsZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 07:48:25 -0500
Date: Fri, 2 Apr 2004 05:48:18 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Torben Mathiasen <torben.mathiasen@hp.com>
Cc: benh@kernel.crashing.org, trini@kernel.crashing.org,
       linux-kernel@vger.kernel.org
Subject: Re: 40x PPC relocation issue during boot
Message-ID: <20040402054818.A3509@home.com>
References: <20040402120712.GF1756@tmathiasen>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040402120712.GF1756@tmathiasen>; from torben.mathiasen@hp.com on Fri, Apr 02, 2004 at 02:07:12PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 02, 2004 at 02:07:12PM +0200, Torben Mathiasen wrote:
> Looking at the current 2.6 tree, there's an issue when one tries to boot a
> zImage image (with or without an attached initrd). This is present in the -benh
> tree as well.
> 
> In ~/arch/ppc/boot/simple/relocate.S the following snip is present:

Tom and I discussed this yesterday since it was breaking ppc44x as
well.  He already has a relocate.S patch in akpm's queue to fix
the issue.

-Matt
