Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263894AbTEWGwA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 02:52:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263918AbTEWGwA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 02:52:00 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:675 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263894AbTEWGvg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 02:51:36 -0400
Subject: Re: 2.5.69-mm8
From: Dave Hansen <haveblue@us.ibm.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Andrew Morton <akpm@digeo.com>, lkml <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
In-Reply-To: <17990000.1053670694@[10.10.2.4]>
References: <20030522021652.6601ed2b.akpm@digeo.com>
	 <17990000.1053670694@[10.10.2.4]>
Content-Type: text/plain
Organization: 
Message-Id: <1053673399.1547.27.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 23 May 2003 00:03:20 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-05-22 at 23:18, Martin J. Bligh wrote:
>       1004     2.0% default_idle
>        272     8.3% __copy_from_user_ll
>        129     1.7% __d_lookup
>         79     7.5% link_path_walk

I have to wonder if these are cache effects, or just noise.  Can you
give oprofile a try with one of the cache performance counters?

-- 
Dave Hansen
haveblue@us.ibm.com

