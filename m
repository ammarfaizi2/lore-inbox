Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965138AbVKBRQ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965138AbVKBRQ0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 12:16:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965139AbVKBRQ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 12:16:26 -0500
Received: from [81.2.110.250] ([81.2.110.250]:34724 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S965138AbVKBRQZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 12:16:25 -0500
Subject: Re: [-mm patch] EDAC: remove proc_ent from struct mem_ctl_info
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20051102162421.GJ8009@stusta.de>
References: <20051024014838.0dd491bb.akpm@osdl.org>
	 <20051102162421.GJ8009@stusta.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 02 Nov 2005 17:44:13 +0000
Message-Id: <1130953454.2432.29.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-11-02 at 17:24 +0100, Adrian Bunk wrote:
> While fixing a compile error with CONFIG_PROC_FS=n in the EDAC code, I 
> discovered that the proc_ent member of struct mem_ctl_info is only used 
> in a debug printk.
> 
> Is this patch to remove proc_ent OK?

Looks sane to me. 
> 
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Acked-by: Alan Cox <alan@redhat.com>



