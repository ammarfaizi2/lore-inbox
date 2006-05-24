Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932624AbWEXHEj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932624AbWEXHEj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 03:04:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932625AbWEXHEj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 03:04:39 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:9607 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932624AbWEXHEi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 03:04:38 -0400
Date: Wed, 24 May 2006 16:05:56 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: ashok.raj@intel.com, linux-kernel@vger.kernel.org, y-goto@jp.fujitsu.com,
       ktokunag@redhat.com, akpm@osdl.org
Subject: Re: [RFC][PATCH] node hotplug : register_cpu() changes [0/3]
Message-Id: <20060524160556.7ea43804.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060524091816.5a3960b9.kamezawa.hiroyu@jp.fujitsu.com>
References: <20060523195636.693e00d6.kamezawa.hiroyu@jp.fujitsu.com>
	<20060523075202.A24516@unix-os.sc.intel.com>
	<20060524091816.5a3960b9.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 May 2006 09:18:15 +0900
KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> wrote:

> I want to migrate per-cpu when a cpu is enabled (if I can). But maybe there
> is a code which has pointer to object in per-cpu area.
> 
I read robust-VM-per_cpu variables thread. If it is merged, I think we can
migrate pages for per_cpu variables (of possible cpus) to suitable nodes,
by remapping.

Thanks,
-Kame

