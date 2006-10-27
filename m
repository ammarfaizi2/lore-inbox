Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752219AbWJ0Oah@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752219AbWJ0Oah (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 10:30:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752222AbWJ0Oah
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 10:30:37 -0400
Received: from mx1.redhat.com ([66.187.233.31]:14538 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1752219AbWJ0Oag (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 10:30:36 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <45420DD4.9020602@sw.ru> 
References: <45420DD4.9020602@sw.ru>  <4541F2A3.8050004@sw.ru> <4541BDE2.6050703@sw.ru> <45409DD5.7050306@sw.ru> <453F6D90.4060106@sw.ru> <453F58FB.4050407@sw.ru> <20792.1161784264@redhat.com> <21393.1161786209@redhat.com> <19898.1161869129@redhat.com> <22562.1161945769@redhat.com> <24249.1161951081@redhat.com> 
To: Vasily Averin <vvs@sw.ru>
Cc: David Howells <dhowells@redhat.com>, Neil Brown <neilb@suse.de>,
       Jan Blunck <jblunck@suse.de>, Olaf Hering <olh@suse.de>,
       Balbir Singh <balbir@in.ibm.com>, Kirill Korotaev <dev@openvz.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       devel@openvz.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [Q] missing unused dentry in prune_dcache()? 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Fri, 27 Oct 2006 15:29:05 +0100
Message-ID: <27160.1161959345@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vasily Averin <vvs@sw.ru> wrote:

> Umount calls shrink_dcache_sb in "Special case for "unmounting" root".
> Usually it happen only once, but in case OpenVZ it happens every time when any
> Virtual server is stopped, each of them have own isolated root partition.

Where is that?  Are you talking about do_remount_sb()?

David
