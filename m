Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264722AbUEEQkR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264722AbUEEQkR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 12:40:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264728AbUEEQkR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 12:40:17 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:49161 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264722AbUEEQkN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 12:40:13 -0400
Date: Wed, 5 May 2004 17:40:09 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Paul Jackson <pj@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc3-mm2
Message-ID: <20040505174009.A5114@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Paul Jackson <pj@sgi.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20040505013135.7689e38d.akpm@osdl.org> <20040505090605.275a0d3a.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040505090605.275a0d3a.pj@sgi.com>; from pj@sgi.com on Wed, May 05, 2004 at 09:06:05AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 05, 2004 at 09:06:05AM -0700, Paul Jackson wrote:
> This doesn't build for ia64 sn2_defconfig (probably not for numa in general).
> One of Andi's patches, numa-api-vma-policy-hooks.patch, is missing four
> #includes of linux/mempolicy.h.

That's actually my fault most likely.  The removal of mempolicy.h from sched.h
and mm.h will need adjustments in quite a few arch files.

