Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262737AbUJ0VWY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262737AbUJ0VWY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 17:22:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262762AbUJ0VTd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 17:19:33 -0400
Received: from mail.dif.dk ([193.138.115.101]:35761 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262760AbUJ0VNW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 17:13:22 -0400
Date: Wed, 27 Oct 2004 23:21:44 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Dual Opteron box, what's the optimal memory placement for the CPUs?
Message-ID: <Pine.LNX.4.61.0410272316160.3284@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Quick question,

I've got an IBM eServer 325 here with 2 Opteron 240 CPUs. The box has 6 
DIMM slots, 4 for the "primary" CPU and 2 for the second one. I've got the 
following memory sticks : 4x512MB and 2x1GB

My plan is to plug the 4 512MB sticks into the slots for the first CPU and 
the 2GB sticks into the two slots for the second CPU, giving them 2GB 
each, but I could also give the first one 2x512MB and 2x1GB and the second 
one 2x512MB giving the first CPU 3GB and the second 1GB. Does it matter at 
all, and if it does, what's the optimal configuration?

--
Jesper Juhl


