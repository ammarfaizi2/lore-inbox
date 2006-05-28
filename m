Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751080AbWE2Acl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbWE2Acl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 20:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751081AbWE2Acl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 20:32:41 -0400
Received: from bhhdoa.org.au ([65.98.99.88]:8463 "EHLO bhhdoa.org.au")
	by vger.kernel.org with ESMTP id S1751080AbWE2Ack (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 20:32:40 -0400
Message-ID: <1148855503.447a24cface24@vds.kolivas.org>
Date: Mon, 29 May 2006 08:31:43 +1000
From: kernel@kolivas.org
To: Diego Calleja <diegocg@gmail.com>
Cc: linux-kernel@vger.kernel.org, folkert@vanheusden.com, ak@suse.de,
       akpm@osdl.org, wfg@mail.ustc.edu.cn, mstone@mathom.us
Subject: Re: [PATCH 00/33] Adaptive read-ahead V12
References: <348469535.17438@ustc.edu.cn> <20060526235436.GD4294@vanheusden.com> <200605271000.12061.kernel@kolivas.org> <200605271008.42137.kernel@kolivas.org> <20060529002032.c5a955a5.diegocg@gmail.com>
In-Reply-To: <20060529002032.c5a955a5.diegocg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Diego Calleja <diegocg@gmail.com>:

> That leaves another question that I (a poor user) may have missed: Why is
> adaptive read-ahead compile-time configurable instead of completely
> replacing
> the old system?

That was done to appease the users out there that had worse performance with it.
In the early stages of development of this code it was rather detrimental on an
ordinary desktop. Fortunately that seems to have gotten a lot better. I don't
think the final version should be a compile time option. It's either "adaptive"
and better everywhere or it's not.

--
-ck

