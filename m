Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265795AbUHALQe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265795AbUHALQe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 07:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265805AbUHALQe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 07:16:34 -0400
Received: from math.ut.ee ([193.40.5.125]:40607 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S265795AbUHALQd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 07:16:33 -0400
Date: Sun, 1 Aug 2004 14:09:02 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [2.4 PATCH] problems with modular and nonmodular ide mix
In-Reply-To: <20040731150214.GG6497@logos.cnet>
Message-ID: <Pine.GSO.4.44.0408011408160.28789-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The thing is cmd640 can't be compiled as a module - just dont
> use IDE modular if you need cmd640.

OK, but should CONFIG_BLK_DEV_CMD640 then depend on CONFIG_BLK_DEV_IDE=y
and show a comment otherwise?

-- 
Meelis Roos (mroos@linux.ee)

