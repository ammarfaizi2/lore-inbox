Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965030AbVJURBD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965030AbVJURBD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 13:01:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965031AbVJURBD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 13:01:03 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:41689 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S965030AbVJURBB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 13:01:01 -0400
Message-ID: <43591E6F.4020506@jp.fujitsu.com>
Date: Sat, 22 Oct 2005 01:59:27 +0900
From: Kamezawa Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Christoph Lameter <clameter@engr.sgi.com>
CC: Simon Derr <Simon.Derr@bull.net>, Andrew Morton <akpm@osdl.org>,
       Mike Kravetz <kravetz@us.ibm.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, Magnus Damm <magnus.damm@gmail.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Paul Jackson <pj@sgi.com>
Subject: Re: [PATCH 4/4] Swap migration V3: sys_migrate_pages interface
References: <20051020225935.19761.57434.sendpatchset@schroedinger.engr.sgi.com> <20051020225955.19761.53060.sendpatchset@schroedinger.engr.sgi.com> <4358588D.1080307@jp.fujitsu.com> <Pine.LNX.4.61.0510210901380.17098@openx3.frec.bull.fr> <435896CA.1000101@jp.fujitsu.com> <Pine.LNX.4.62.0510210926120.23328@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.62.0510210926120.23328@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> On Fri, 21 Oct 2005, KAMEZAWA Hiroyuki wrote:
> 
> 
>>>>How about this ?
>>>>+cpuset_update_task_mems_allowed(task, new);    (this isn't implemented
>>>>now
>>
>>*new* is already guaranteed to be the subset of current mem_allowed.
>>Is this violate the permission ?
> 
>  
> Could the cpuset_mems_allowed(task) function update the mems_allowed if 
> needed?
It looks I was wrong :(
see Paul's e-mail. he describes the problem of my suggestion in detail.

-- Kame

