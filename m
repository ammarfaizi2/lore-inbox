Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275260AbTHMPiw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 11:38:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275239AbTHMPiw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 11:38:52 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:59889 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id S275260AbTHMPiX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 11:38:23 -0400
Date: Wed, 13 Aug 2003 16:40:00 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Coen Rosdorff <coen@rosdorff.dyndns.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: VM: killing process amavis
In-Reply-To: <Pine.LNX.4.44.0308131708570.29133-100000@rosdorff.dyndns.org>
Message-ID: <Pine.LNX.4.44.0308131633420.2029-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Aug 2003, Coen Rosdorff wrote:
> Who can tell me something about this error in /var/log/messages:
> 
> Aug 13 10:12:51 rosdorff kernel: VM: killing process amavis
> Aug 13 10:12:51 rosdorff kernel: swap_free: Unused swap offset entry 02000000
> 
> Memtest86: No errors.

It really would be worth giving memtest86 a good long run.

02000000 looks very much like a single-bit memory error,
and swap_free is exactly where such errors often show up.

Hugh

