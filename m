Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263800AbUEMGHn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263800AbUEMGHn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 02:07:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263802AbUEMGHn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 02:07:43 -0400
Received: from holomorphy.com ([207.189.100.168]:3260 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263800AbUEMGHm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 02:07:42 -0400
Date: Wed, 12 May 2004 23:06:39 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: David Gibson <david@gibson.dropbear.id.au>, Andrew Morton <akpm@osdl.org>,
       Anton Blanchard <anton@samba.org>, Adam Litke <agl@us.ibm.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel@vger.kernel.org, linuxppc64-dev@lists.linuxppc.org
Subject: Re: More convenient way to grab hugepage memory
Message-ID: <20040513060639.GN1397@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	David Gibson <david@gibson.dropbear.id.au>,
	Andrew Morton <akpm@osdl.org>, Anton Blanchard <anton@samba.org>,
	Adam Litke <agl@us.ibm.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linux-kernel@vger.kernel.org, linuxppc64-dev@lists.linuxppc.org
References: <20040513055520.GF27403@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040513055520.GF27403@zax>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2004 at 03:55:20PM +1000, David Gibson wrote:
> +int mmap_use_hugepages = 0;
> +int mmap_hugepages_map_sz = 256;

These aren't used anywhere else in your patch; any chance you could
nuke them?

Thanks.


-- wli

