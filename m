Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264838AbTBTEil>; Wed, 19 Feb 2003 23:38:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264844AbTBTEil>; Wed, 19 Feb 2003 23:38:41 -0500
Received: from holomorphy.com ([66.224.33.161]:9373 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S264838AbTBTEik>;
	Wed, 19 Feb 2003 23:38:40 -0500
Date: Wed, 19 Feb 2003 20:47:48 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: Performance of partial object-based rmap
Message-ID: <20030220044748.GE22687@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	lse-tech <lse-tech@lists.sourceforge.net>
References: <7490000.1045715152@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7490000.1045715152@[10.10.2.4]>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2003 at 08:25:52PM -0800, Martin J. Bligh wrote:
> Profile comparison:
> before
> 	15525 page_remove_rmap
> 	6415 page_add_rmap
> after
> 	2055 page_add_rmap
> 	1983 page_remove_rmap

Could I get a larger, multiplicative differential profile?
i.e. ratios of the fractions of profile hits?

If you have trouble generating such I can do so myself from
fuller profile results.


Thanks.


-- wli
