Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269221AbUINJOV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269221AbUINJOV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 05:14:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269229AbUINJOV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 05:14:21 -0400
Received: from fw.osdl.org ([65.172.181.6]:32665 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269221AbUINJOM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 05:14:12 -0400
Date: Tue, 14 Sep 2004 02:12:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nikita Danilov <nikita@clusterfs.com>
Cc: rjw@sisk.pl, ak@suse.de, linux-kernel@vger.kernel.org,
       David Howells <dhowells@redhat.com>
Subject: Re: 2.6.9-rc1-mm5
Message-Id: <20040914021206.6879ed86.akpm@osdl.org>
In-Reply-To: <16710.46269.961782.124751@thebsh.namesys.com>
References: <20040913015003.5406abae.akpm@osdl.org>
	<200409132306.38340.rjw@sisk.pl>
	<16710.46269.961782.124751@thebsh.namesys.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita Danilov <nikita@clusterfs.com> wrote:
>
> include/linux/key.h defines struct key that conflicts with reiserfs'
>  struct key. As a temporary fix turn off CONFIG_KEYS (or
>  CONFIG_REISERFS_FS :)).
> 
>  Correct solution is to put both structs into proper namespaces by
>  prefixing them.

struct key was pretty dumb of both of you, but reiserfs was dumb first.

David, what do you want it renamed to?
