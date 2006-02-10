Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932221AbWBJV71@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932221AbWBJV71 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 16:59:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932220AbWBJV70
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 16:59:26 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:35229 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932215AbWBJV7Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 16:59:25 -0500
Message-ID: <43ED0CB5.2060104@austin.ibm.com>
Date: Fri, 10 Feb 2006 15:59:17 -0600
From: Joel Schopp <jschopp@austin.ibm.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Yasunori Goto <y-goto@jp.fujitsu.com>
CC: "Luck, Tony" <tony.luck@intel.com>, Andi Kleen <ak@suse.de>,
       "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>,
       linux-ia64@vger.kernel.org,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       x86-64 Discuss <discuss@x86-64.org>,
       Linux Hotplug Memory Support 
	<lhms-devel@lists.sourceforge.net>
Subject: Re: [Lhms-devel] [RFC/PATCH: 002/010] Memory hotplug for new nodes
 with pgdat allocation. (Wait table and zonelists initalization)
References: <20060210223841.C532.Y-GOTO@jp.fujitsu.com>
In-Reply-To: <20060210223841.C532.Y-GOTO@jp.fujitsu.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +	/* When hot-dadd, present page is 0 at this point.
> +	   So check spanned_pages instead of present_pages */
> +	return (!!zone->spanned_pages);
>  }

Typo in comment.
