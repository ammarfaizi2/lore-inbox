Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261462AbUCAWje (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 17:39:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261465AbUCAWje
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 17:39:34 -0500
Received: from ns.suse.de ([195.135.220.2]:55473 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261462AbUCAWjd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 17:39:33 -0500
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: per-cpu blk_plug_list II
References: <B05667366EE6204181EABE9C1B1C0EB501F2AB4C@scsmsx401.sc.intel.com>
From: Andi Kleen <ak@suse.de>
In-Reply-To: <B05667366EE6204181EABE9C1B1C0EB501F2AB4C@scsmsx401.sc.intel.com.suse.lists.linux.kernel>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Date: 01 Mar 2004 23:39:32 +0100
Message-ID: <p73oergyyxn.fsf@verdi.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I don't see any mechanism in your patch to make sure the queue on the previous
> CPU is flushed too. 

Never mind. It's right in there with the for_each_cpu of course and I
somehow overlooked it.

-Andi
R
