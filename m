Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262883AbUBZRON (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 12:14:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262884AbUBZRON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 12:14:13 -0500
Received: from ns.suse.de ([195.135.220.2]:19112 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262883AbUBZROI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 12:14:08 -0500
To: Brian Childs <brian@rentec.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Multicast broken on x86_64 (Patch Included)
References: <20040226162652.GG1760@rentec.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 26 Feb 2004 18:14:06 +0100
In-Reply-To: <20040226162652.GG1760@rentec.com.suse.lists.linux.kernel>
Message-ID: <p737jy969wh.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Childs <brian@rentec.com> writes:

> csum-partial.c in 2.4.25 and 2.6.3 has a bug that causes it to compute
> the checksum incorrectly.
> 
> As a result, multicast doesn't work.  It looks as though iptables is
> also affected.
> 
> Anyway, here's a simple patch.

Thanks. Added.

-Andi
