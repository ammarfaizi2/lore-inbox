Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263567AbTETEC3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 00:02:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263558AbTETEC3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 00:02:29 -0400
Received: from waste.org ([209.173.204.2]:10932 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S263552AbTETEC2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 00:02:28 -0400
Date: Mon, 19 May 2003 23:15:20 -0500
From: Matt Mackall <mpm@selenic.com>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ANNOUNCE: wiggle - a tools for applying patches with conflicts
Message-ID: <20030520041520.GP23380@waste.org>
References: <16073.40798.305573.92933@notabene.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16073.40798.305573.92933@notabene.cse.unsw.edu.au>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 20, 2003 at 01:22:06PM +1000, Neil Brown wrote:
> 
> I am pleased to announce the first public release of 'wiggle'.
> 
> Wiggle is a program for applying patches that 'patch' cannot
> apply due to conflicting changes in the original.
> 
> Wiggle will always apply all changes in the patch to the original.
> If it cannot find a way to cleanly apply a patch, it inserts it
> in the original in a manner similar to 'merge', and report an
> unresolvable conflict.  Such a conflict will look like:

Very clever. An option to generate traditional .rej files rather than
inline conflicts would be nice; I hate the latter.

-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon
