Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262550AbUCEMIx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 07:08:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262559AbUCEMIx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 07:08:53 -0500
Received: from colino.net ([62.212.100.143]:58099 "EHLO paperstreet.colino.net")
	by vger.kernel.org with ESMTP id S262550AbUCEMIw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 07:08:52 -0500
Date: Fri, 5 Mar 2004 13:08:03 +0100
From: Colin Leroy <colin@colino.net>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.6 ide-cd DMA ripping
Message-Id: <20040305130803.0c01ee83@jack.colino.net>
Organization: 
X-Mailer: Sylpheed version 0.9.8claws (GTK+ 2.2.4; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
In-Reply-To: <20040304152840.GL2708@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>I'd appreciate people giving this a test spin. Patch is against
>2.6.4-rc1 (well current BK, actually).

Works (on ppc, ibook G4 here). It's indeed faster. But, it breaks direct 
output to dsp (as in `cdparanoia 1 /dev/dsp`). 

HTH,
-- 
Colin
