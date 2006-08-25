Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030191AbWHYO6U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030191AbWHYO6U (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 10:58:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030208AbWHYO6U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 10:58:20 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:49321 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030193AbWHYO6R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 10:58:17 -0400
Subject: Re: memory hotplug - looking for good place for cpuset hook
From: Dave Hansen <haveblue@us.ibm.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: Paul Jackson <pj@sgi.com>, linux-kernel@vger.kernel.org, anton@samba.org,
       simon.derr@bull.net, nathanl@austin.ibm.com, akpm@osdl.org,
       GOTO <y-goto@jp.fujitsu.com>
In-Reply-To: <20060825184717.3dbb5325.kamezawa.hiroyu@jp.fujitsu.com>
References: <20060825015359.1c9eab45.pj@sgi.com>
	 <20060825184717.3dbb5325.kamezawa.hiroyu@jp.fujitsu.com>
Content-Type: text/plain
Date: Fri, 25 Aug 2006 07:58:05 -0700
Message-Id: <1156517885.12011.170.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-25 at 18:47 +0900, KAMEZAWA Hiroyuki wrote:
> 
> if (new_pgdat) {
>         register_one_node(nid); <-- add sysfs entry of node
>         <here>
> }
> 
> is good.
> 
> (When I implements node-hotplug invoked by cpu-hotplug, I'll care
> cpuset.) 

Looks like someone beat me to the punch.  Putting it in there would be
fine with me.  Gets it a wee bit farther from memory hotplug anyway. ;)

-- Dave

