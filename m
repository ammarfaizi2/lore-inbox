Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966660AbWKOFmz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966660AbWKOFmz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 00:42:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966661AbWKOFmy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 00:42:54 -0500
Received: from smtp.osdl.org ([65.172.181.4]:33429 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S966660AbWKOFmy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 00:42:54 -0500
Date: Tue, 14 Nov 2006 21:42:47 -0800
From: Andrew Morton <akpm@osdl.org>
To: Trond Myklebust <Trond.Myklebust@netapp.com>
Cc: Charles Edward Lever <chucklever@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Yet another borken page_count() check in
 invalidate_inode_pages2()....
Message-Id: <20061114214247.7e01c09e.akpm@osdl.org>
In-Reply-To: <1163568819.5645.8.camel@lade.trondhjem.org>
References: <1163568819.5645.8.camel@lade.trondhjem.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Nov 2006 00:33:39 -0500
Trond Myklebust <Trond.Myklebust@netapp.com> wrote:

> I'm once again getting bogus errors from invalidate_inode_pages2() due
> to a VM bug. See the third line of remove_mapping().
> 

invalidate_inode_pages2() doesn't use remove_mapping().
