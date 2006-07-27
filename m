Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750767AbWG0Afy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767AbWG0Afy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 20:35:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750835AbWG0Afy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 20:35:54 -0400
Received: from mx1.redhat.com ([66.187.233.31]:61626 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750767AbWG0Afy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 20:35:54 -0400
Date: Wed, 26 Jul 2006 20:35:38 -0400
From: Dave Jones <davej@redhat.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Dave Airlie <airlied@linux.ie>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] vm/agp: remove private page protection map
Message-ID: <20060727003538.GD5687@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Hugh Dickins <hugh@veritas.com>, Dave Airlie <airlied@linux.ie>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <Pine.LNX.4.64.0607181905140.26533@skynet.skynet.ie> <Pine.LNX.4.64.0607262135440.11629@blonde.wat.veritas.com> <Pine.LNX.4.64.0607270023120.23571@skynet.skynet.ie> <Pine.LNX.4.64.0607270059220.17518@blonde.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0607270059220.17518@blonde.wat.veritas.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2006 at 12:59:44AM +0100, Hugh Dickins wrote:

 > Thanks.  By the way, I hope you noticed that some architectures
 > (arm, m68k, sparc, sparc64) may adjust protection_map[] at startup:
 > so the old agp_convert_mmap_flags would supply the compiled in prot,
 > whereas the new agp_convert_mmap_flags supplies the adjusted prot.
 > 
 > I assume this is either irrelevant to you (no AGP on some arches?)

AGP doesn't exist on any of the above architectures.

		Dave

-- 
http://www.codemonkey.org.uk
