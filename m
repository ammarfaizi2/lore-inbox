Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964978AbVJUPW7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964978AbVJUPW7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 11:22:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964979AbVJUPW7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 11:22:59 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:36249 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S964978AbVJUPW6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 11:22:58 -0400
Message-ID: <43590789.1070309@jp.fujitsu.com>
Date: Sat, 22 Oct 2005 00:21:45 +0900
From: Kamezawa Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: Simon.Derr@bull.net, clameter@sgi.com, akpm@osdl.org, kravetz@us.ibm.com,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org, magnus.damm@gmail.com,
       marcelo.tosatti@cyclades.com
Subject: Re: [PATCH 4/4] Swap migration V3: sys_migrate_pages interface
References: <20051020225935.19761.57434.sendpatchset@schroedinger.engr.sgi.com>	<20051020225955.19761.53060.sendpatchset@schroedinger.engr.sgi.com>	<4358588D.1080307@jp.fujitsu.com>	<Pine.LNX.4.61.0510210901380.17098@openx3.frec.bull.fr>	<435896CA.1000101@jp.fujitsu.com> <20051021081553.50716b97.pj@sgi.com>
In-Reply-To: <20051021081553.50716b97.pj@sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:
> I agree with Simon that sys_migrate_pages() does not want to get in
> the business of replicating the checks on updating mems_allowed that
> are in the cpuset code.
> 
Hm.. okay.
I'm just afraid of swapped-out pages will goes back to original nodes

-- Kame

