Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946266AbWJ0Jia@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946266AbWJ0Jia (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 05:38:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946267AbWJ0Jia
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 05:38:30 -0400
Received: from mx1.redhat.com ([66.187.233.31]:14232 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1946266AbWJ0Jia (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 05:38:30 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <4541AC45.7030300@sw.ru> 
References: <4541AC45.7030300@sw.ru>  <4540A0C5.60700@sw.ru> <453F58FB.4050407@sw.ru> <19857.1161869015@redhat.com> <4541A803.9000004@sw.ru> 
To: Vasily Averin <vvs@sw.ru>
Cc: aviro@redhat.com, Neil Brown <neilb@suse.de>, Jan Blunck <jblunck@suse.de>,
       Olaf Hering <olh@suse.de>, Balbir Singh <balbir@in.ibm.com>,
       Kirill Korotaev <dev@openvz.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       devel@openvz.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [Q] missing unused dentry in prune_dcache()? 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Fri, 27 Oct 2006 10:36:37 +0100
Message-ID: <12282.1161941797@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vasily Averin <vvs@sw.ru> wrote:

> > You should correct dentry_stat.nr_dentry, but instead you broke
> > calculation of dentry_stat.nr_unused.
> > 
> > I've fixed this issue by following patch.
> corrected version, extra space were removed

Oops.  You're right.

Acked-By: David Howells <dhowells@redhat.com>
