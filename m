Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750786AbWHPSq1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750786AbWHPSq1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 14:46:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbWHPSq1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 14:46:27 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:57761 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750786AbWHPSq0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 14:46:26 -0400
Subject: Re: [RFC][PATCH 4/7] UBC: syscalls (user interface)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: rohitseth@google.com
Cc: Kirill Korotaev <dev@sw.ru>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>, hugh@veritas.com,
       ckrm-tech@lists.sourceforge.net, Andi Kleen <ak@suse.de>
In-Reply-To: <1155752277.22595.70.camel@galaxy.corp.google.com>
References: <44E33893.6020700@sw.ru>  <44E33C3F.3010509@sw.ru>
	 <1155752277.22595.70.camel@galaxy.corp.google.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 16 Aug 2006 20:04:29 +0100
Message-Id: <1155755069.24077.392.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-08-16 am 11:17 -0700, ysgrifennodd Rohit Seth:
> I think there should be a check here for seeing if the new limits are
> lower than the current usage of a resource.  If so then take appropriate
> action.

Generally speaking there isn't a sane appropriate action because the
resources can't just be yanked.

