Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265177AbTBPBfU>; Sat, 15 Feb 2003 20:35:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265196AbTBPBfU>; Sat, 15 Feb 2003 20:35:20 -0500
Received: from holomorphy.com ([66.224.33.161]:9864 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S265177AbTBPBfU>;
	Sat, 15 Feb 2003 20:35:20 -0500
Date: Sat, 15 Feb 2003 17:44:15 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Oliver Neukum <oliver@neukum.name>
Cc: linux-kernel@vger.kernel.org
Subject: Re: clean up SLAB_KERNEL non-usage
Message-ID: <20030216014415.GL29983@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Oliver Neukum <oliver@neukum.name>, linux-kernel@vger.kernel.org
References: <20030215114054.GA32256@holomorphy.com> <200302151658.59007.oliver@neukum.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302151658.59007.oliver@neukum.name>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 15. Februar 2003 12:40 schrieb William Lee Irwin III:
>> Use SLAB_KERNEL and SLAB_ATOMIC instead of GFP_KERNEL and GFP_ATOMIC
>> when passing args to slab allocation functions.

On Sat, Feb 15, 2003 at 04:58:58PM +0100, Oliver Neukum wrote:
> What is this distinction supposed to do anyway?
> Can't we just drop it?

That's why I followed up with patches that remove them in favor of GFP_*

-- wli
