Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261270AbUAaDMN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 22:12:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261406AbUAaDMN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 22:12:13 -0500
Received: from ns.suse.de ([195.135.220.2]:13780 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261270AbUAaDMM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 22:12:12 -0500
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, michael@mvdavid.com
Subject: Re: raid6 badness
References: <Pine.LNX.4.58.0401301158340.8900@sapphire.newearth.org.suse.lists.linux.kernel>
	<bvf2vl$6pr$1@terminus.zytor.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 31 Jan 2004 04:04:23 +0100
In-Reply-To: <bvf2vl$6pr$1@terminus.zytor.com.suse.lists.linux.kernel>
Message-ID: <p73ad44n7ig.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:
> 
> I don't know what would cause the stack to be misaligned, however.

x86-64 kernel doesn't guarantee the stack to be 16 byte aligned
(although it usually is). If you need 16 byte alignment you have 
to align yourself.

-Andi
