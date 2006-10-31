Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751723AbWJaKmO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751723AbWJaKmO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 05:42:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422872AbWJaKmO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 05:42:14 -0500
Received: from mx1.redhat.com ([66.187.233.31]:451 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751723AbWJaKmM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 05:42:12 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <17734.54114.192151.271984@cse.unsw.edu.au> 
References: <17734.54114.192151.271984@cse.unsw.edu.au>  <4541BDE2.6050703@sw.ru> <45409DD5.7050306@sw.ru> <453F6D90.4060106@sw.ru> <453F58FB.4050407@sw.ru> <20792.1161784264@redhat.com> <21393.1161786209@redhat.com> <19898.1161869129@redhat.com> <22562.1161945769@redhat.com> <24249.1161951081@redhat.com> <4542123E.4030309@sw.ru> <20061030042419.GW8394166@melbourne.sgi.com> <45459B92.400@sw.ru> 
To: Neil Brown <neilb@suse.de>
Cc: Kirill Korotaev <dev@sw.ru>, devel@openvz.org, Vasily Averin <vvs@sw.ru>,
       Andrew Morton <akpm@osdl.org>, Kirill Korotaev <dev@openvz.org>,
       Balbir Singh <balbir@in.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       David Howells <dhowells@redhat.com>, Olaf Hering <olh@suse.de>,
       Jan Blunck <jblunck@suse.de>
Subject: Re: [Devel] Re: [PATCH 2.6.19-rc3] VFS: per-sb dentry lru list 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Tue, 31 Oct 2006 10:40:14 +0000
Message-ID: <25762.1162291214@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown <neilb@suse.de> wrote:

> When we unmount a filesystem we need to release all dentries.
> We currently
>   - move a collection of dentries to the end of the dentry_unused list
>   - call prune_dcache to prune that number of dentries.

This is not true anymore.

David
