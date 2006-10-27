Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752224AbWJ0OcZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752224AbWJ0OcZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 10:32:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752225AbWJ0OcZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 10:32:25 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:28535 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1752211AbWJ0OcY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 10:32:24 -0400
Message-ID: <45421A38.7060307@sw.ru>
Date: Fri, 27 Oct 2006 18:39:52 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: David Howells <dhowells@redhat.com>
CC: Vasily Averin <vvs@sw.ru>, Neil Brown <neilb@suse.de>,
       Jan Blunck <jblunck@suse.de>, Olaf Hering <olh@suse.de>,
       Balbir Singh <balbir@in.ibm.com>, Kirill Korotaev <dev@openvz.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       devel@openvz.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [Q] missing unused dentry in prune_dcache()?
References: <45420DD4.9020602@sw.ru>  <4541F2A3.8050004@sw.ru> <4541BDE2.6050703@sw.ru> <45409DD5.7050306@sw.ru> <453F6D90.4060106@sw.ru> <453F58FB.4050407@sw.ru> <20792.1161784264@redhat.com> <21393.1161786209@redhat.com> <19898.1161869129@redhat.com> <22562.1161945769@redhat.com> <24249.1161951081@redhat.com> <27160.1161959345@redhat.com>
In-Reply-To: <27160.1161959345@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Vasily Averin <vvs@sw.ru> wrote:
> 
> 
>>Umount calls shrink_dcache_sb in "Special case for "unmounting" root".
>>Usually it happen only once, but in case OpenVZ it happens every time when any
>>Virtual server is stopped, each of them have own isolated root partition.
> 
> 
> Where is that?  Are you talking about do_remount_sb()?
AFAIR yes.

Kirill
