Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268409AbUI2N3j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268409AbUI2N3j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 09:29:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268392AbUI2N3j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 09:29:39 -0400
Received: from colossus.systems.pipex.net ([62.241.160.73]:35560 "EHLO
	colossus.systems.pipex.net") by vger.kernel.org with ESMTP
	id S268397AbUI2N3b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 09:29:31 -0400
Message-ID: <415AB8B4.4090408@tungstengraphics.com>
Date: Wed, 29 Sep 2004 14:29:24 +0100
From: Keith Whitwell <keith@tungstengraphics.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a3) Gecko/20040817
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
Cc: Jon Smirl <jonsmirl@gmail.com>,
       dri-devel <dri-devel@lists.sourceforge.net>,
       Xserver development <xorg@freedesktop.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: New DRM driver model - gets rid of DRM() macros!
References: <9e4733910409280854651581e2@mail.gmail.com> <20040929133759.A11891@infradead.org>
In-Reply-To: <20040929133759.A11891@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:

>  - drm_flush is a noop.  a NULL ->flush does the same thing, just easier
>  - dito or ->poll
>  - dito for ->read

Pretty sure you couldn't get away with null for these in 2.4, at least.

Keith
