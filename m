Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317898AbSIOHMp>; Sun, 15 Sep 2002 03:12:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317931AbSIOHMp>; Sun, 15 Sep 2002 03:12:45 -0400
Received: from holomorphy.com ([66.224.33.161]:19929 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S317898AbSIOHMp>;
	Sun, 15 Sep 2002 03:12:45 -0400
Date: Sun, 15 Sep 2002 00:17:27 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>, Dave Hansen <haveblue@us.ibm.com>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] add vmalloc stats to meminfo
Message-ID: <20020915071727.GI3530@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>, Dave Hansen <haveblue@us.ibm.com>,
	"Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <3D8422BB.5070104@us.ibm.com> <3D84340A.25ED4C69@digeo.com> <20020915071157.GH3530@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <20020915071157.GH3530@holomorphy.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 15, 2002 at 12:11:57AM -0700, William Lee Irwin III wrote:
> Also, dynamic vmalloc allocations may very well be starved by boot-time
> allocations on systems where much vmallocspace is required for IO memory.
> The failure mode of such is effectively deadlock, since they block
> indefinitely waiting for permanent boot-time allocations to be freed up.

This is dead wrong. NFI wtf I was thinking. Ignore that one.


Bill
