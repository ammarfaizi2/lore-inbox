Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261316AbUL2EbL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261316AbUL2EbL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 23:31:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261317AbUL2EbL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 23:31:11 -0500
Received: from fw.osdl.org ([65.172.181.6]:25512 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261316AbUL2EbJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 23:31:09 -0500
Date: Tue, 28 Dec 2004 20:31:05 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Frank Denis \(Jedi/Sector One\)" <lkml@pureftpd.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at fs/namei.c:2333 (reiserfs related?)
Message-Id: <20041228203105.57467469.akpm@osdl.org>
In-Reply-To: <20041227112349.GA29389@c9x.org>
References: <20041227112349.GA29389@c9x.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Frank Denis \(Jedi/Sector One\)" <lkml@pureftpd.org> wrote:
>
>   I just got that one with kernel 2.6.10-rc3-mm1:
>    
>  kernel BUG at fs/namei.c:2333!

Were filesystem quotas in use at the time?

