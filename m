Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272276AbTG3W1o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 18:27:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272279AbTG3W1o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 18:27:44 -0400
Received: from fw.osdl.org ([65.172.181.6]:438 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272276AbTG3W1l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 18:27:41 -0400
Date: Wed, 30 Jul 2003 15:16:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: Shawn <core@enodev.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Buffer I/O error on device hde3, logical block 4429
Message-Id: <20030730151600.04be29bb.akpm@osdl.org>
In-Reply-To: <1059585712.11341.24.camel@localhost>
References: <1059585712.11341.24.camel@localhost>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shawn <core@enodev.com> wrote:
>
> I am running 2.6.0-test2-mm1, and upon boot have received a gift of many
> "Buffer I/O error on device hde3" messages in my log. After they quit,
> they never seem to come back.

Please just ignore them.  They are noise arising from the new readahead
behaviour in the block layer.

