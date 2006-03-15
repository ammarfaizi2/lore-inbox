Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751837AbWCOLzz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751837AbWCOLzz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 06:55:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751839AbWCOLzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 06:55:55 -0500
Received: from smtp.osdl.org ([65.172.181.4]:62636 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751837AbWCOLzy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 06:55:54 -0500
Date: Wed, 15 Mar 2006 03:53:20 -0800
From: Andrew Morton <akpm@osdl.org>
To: Alexander Gran <alex@zodiac.dnsalias.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel Bug while trying to mount nfs share
Message-Id: <20060315035320.1dce9324.akpm@osdl.org>
In-Reply-To: <200603151244.34159@zodiac.zodiac.dnsalias.org>
References: <200603151244.34159@zodiac.zodiac.dnsalias.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Gran <alex@zodiac.dnsalias.org> wrote:
>
> just tried to mount a NFS share under 2.6.16-rc6-mm1. Didn't work out:
>

yup, sorry, nfs is unwell there.  Trond has fixed a few things and I've
dropped the superblock-sharing patches so hopefully next -mm will be
better...
