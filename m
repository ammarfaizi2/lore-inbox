Return-Path: <linux-kernel-owner+w=401wt.eu-S932138AbWLLHqd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138AbWLLHqd (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 02:46:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932140AbWLLHqd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 02:46:33 -0500
Received: from il.qumranet.com ([62.219.232.206]:58753 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932138AbWLLHqc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 02:46:32 -0500
Message-ID: <457E5E56.3060308@qumranet.com>
Date: Tue, 12 Dec 2006 09:46:30 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Randy Dunlap <randy.dunlap@oracle.com>
CC: kvm-devel@lists.sourceforge.net, lkml <linux-kernel@vger.kernel.org>,
       akpm <akpm@osdl.org>
Subject: Re: [PATCH] kvm needs menu structure
References: <20061211144418.f10a7f5b.randy.dunlap@oracle.com>
In-Reply-To: <20061211144418.f10a7f5b.randy.dunlap@oracle.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap wrote:
> From: Randy Dunlap <randy.dunlap@oracle.com>
>
> KVM config items need to be inside a menu structure instead of
> dangling off of Device Drivers.
>
>   

A similar patch (kvm-put-kvm-in-a-new-virtualization-menu.patch) is 
already queued in -mm.

Andrew, Randy's patch shouldn't be applied, unless there's strong 
feeling for a doubly-nested menu.

-- 
error compiling committee.c: too many arguments to function

