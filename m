Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263676AbTFLJPi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 05:15:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264424AbTFLJPi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 05:15:38 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:35766 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S263676AbTFLJPg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 05:15:36 -0400
Date: Thu, 12 Jun 2003 11:29:16 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: torvalds@transmeta.com, trivial@rustcorp.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] __cat and __unique_id in stringify.h
Message-ID: <20030612092916.GB1718@wohnheim.fh-wedel.de>
References: <20030612064224.DBE562C019@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030612064224.DBE562C019@lists.samba.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 June 2003 16:41:53 +1000, Rusty Russell wrote:
> +/* Paste two tokens together. */
> +#define ___cat(a,b) a ## b
> +#define __cat(a,b) ___cat(a,b)

It might be a bit too easy to type ___cat instead of __cat.  If you
use ___cat___ or something similar, there might be less problems
caused by typing problems.

Jörn

-- 
With a PC, I always felt limited by the software available. On Unix, 
I am limited only by my knowledge.
-- Peter J. Schoenster
