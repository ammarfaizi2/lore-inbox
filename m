Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262479AbUKWADR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262479AbUKWADR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 19:03:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262470AbUKWAAv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 19:00:51 -0500
Received: from fw.osdl.org ([65.172.181.6]:3541 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262462AbUKVX7I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 18:59:08 -0500
Date: Mon, 22 Nov 2004 16:03:18 -0800
From: Andrew Morton <akpm@osdl.org>
To: Brice.Goglin@ens-lyon.org
Cc: Brice.Goglin@ens-lyon.fr, linux-kernel@vger.kernel.org
Subject: Re: kmap_atomic
Message-Id: <20041122160318.275fba69.akpm@osdl.org>
In-Reply-To: <41A1FDA0.1070204@ens-lyon.fr>
References: <41A1FDA0.1070204@ens-lyon.fr>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brice Goglin <Brice.Goglin@ens-lyon.fr> wrote:
>
> I would like to know if I can use kmap_atomic with KM_USER[01] type
> within a non-interrupt context.

That is what they are designed for.  Using KM_USER0 and KM_USER1 in
non-interrupt context is correct.

