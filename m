Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261640AbTKLWZk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 17:25:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261662AbTKLWZk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 17:25:40 -0500
Received: from colin2.muc.de ([193.149.48.15]:46345 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261640AbTKLWZj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 17:25:39 -0500
Date: 12 Nov 2003 23:26:09 +0100
Date: Wed, 12 Nov 2003 23:26:09 +0100
From: Andi Kleen <ak@colin2.muc.de>
To: Peter Chubb <peter@chubb.wattle.id.au>
Cc: Andi Kleen <ak@muc.de>,
       Bernd Schubert <Bernd.Schubert@tc.pci.uni-heidelberg.de>,
       linux-kernel@vger.kernel.org
Subject: Re: 2 TB partition support
Message-ID: <20031112222609.GA2924@colin2.muc.de>
References: <QugF.3Mq.7@gated-at.bofh.it> <Qwit.771.11@gated-at.bofh.it> <QR40.39P.53@gated-at.bofh.it> <m3d6bybeiw.fsf@averell.firstfloor.org> <16306.35809.15450.378197@wombat.chubb.wattle.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16306.35809.15450.378197@wombat.chubb.wattle.id.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Has the kmalloc problem in Reiserfs gone away?  It used to be that the
> limit for a Reiser filesystem was determined by how many pointers
> could fit into a kmalloced chunk of memory; thus the 64-bit system
> limit was half teh 32-bit system limit.

I don't know. i haven't tested reiserfs (or any other fs) with big file 
systems.

I was just talking about the theoretic limits in the block layer.

-Andi
