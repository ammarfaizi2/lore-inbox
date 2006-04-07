Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932303AbWDGDMq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932303AbWDGDMq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 23:12:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932305AbWDGDMq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 23:12:46 -0400
Received: from blackbird.sr71.net ([64.146.134.44]:23452 "EHLO
	blackbird.sr71.net") by vger.kernel.org with ESMTP id S932303AbWDGDMp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 23:12:45 -0400
Subject: Re: [Patch:003/004] wait_table and zonelist initializing for
	memory hotadd (wait_table initialization)
From: Dave Hansen <dave@sr71.net>
To: Yasunori Goto <y-goto@jp.fujitsu.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>
In-Reply-To: <20060407104859.EBED.Y-GOTO@jp.fujitsu.com>
References: <20060405195913.3C45.Y-GOTO@jp.fujitsu.com>
	 <1144361104.9731.190.camel@localhost.localdomain>
	 <20060407104859.EBED.Y-GOTO@jp.fujitsu.com>
Content-Type: text/plain
Date: Thu, 06 Apr 2006 20:12:04 -0700
Message-Id: <1144379524.9731.192.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-04-07 at 12:10 +0900, Yasunori Goto wrote:
> 
> This size doesn't mean bytes. It is hash table entry size.
> So, wait_table_hash_size() or wait_table_entry_size() might be better.

wait_table_hash_nr_entries() is pretty obvious, although a bit long.

-- Dave

