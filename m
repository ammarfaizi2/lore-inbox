Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263575AbTHZKHO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 06:07:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263583AbTHZKHO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 06:07:14 -0400
Received: from holomorphy.com ([66.224.33.161]:30126 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263575AbTHZKHN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 06:07:13 -0400
Date: Tue, 26 Aug 2003 03:08:24 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test4-mm1
Message-ID: <20030826100824.GQ4306@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20030824171318.4acf1182.akpm@osdl.org> <30190000.1061853042@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30190000.1061853042@flay>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 25, 2003 at 04:10:42PM -0700, Martin J. Bligh wrote:
>       7763     4.8% total
>       2921     6.4% default_idle
>        949     0.0% direct_strnlen_user
>        719    20.6% __copy_from_user_ll
>        554    10.4% __copy_to_user_ll
>        544    33.5% kmem_cache_free
>        425     0.0% kpmd_ctor
>        372    26.1% schedule
>        349    18.7% atomic_dec_and_lock
>        322     4.1% __d_lookup
>        318     8.6% find_get_page
>        283   165.5% may_open

Hmm, seeing functions I wrote in diffprofiles like this gives me the
wli's. Any chance you could snapshot /proc/slabinfo say every 1s during
a run so I can see what's going on?


-- wli
