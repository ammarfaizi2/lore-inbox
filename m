Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270933AbTG0Wwp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 18:52:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270967AbTG0Wwp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 18:52:45 -0400
Received: from zeus.kernel.org ([204.152.189.113]:65009 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S270933AbTG0Wwo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 18:52:44 -0400
Date: Sun, 27 Jul 2003 15:26:20 -0700
From: "David S. Miller" <davem@redhat.com>
To: Doruk Fisek <dfisek@fisek.com.tr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: hw tcp v4 csum failed
Message-Id: <20030727152620.5efa995d.davem@redhat.com>
In-Reply-To: <20030727100246.4bfb860c.dfisek@fisek.com.tr>
References: <20030727100246.4bfb860c.dfisek@fisek.com.tr>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Jul 2003 10:02:46 +0300
Doruk Fisek <dfisek@fisek.com.tr> wrote:

> Hi,
> 
>  I am getting "hw tcp v4 csum failed" errors using a BCM5701 ethernet
> adapter with the tigon3 driver in a vanilla 2.4.20 kernel.
> 
>  There seems to be no apparent problem (probably because of low-load).
> 
>  What can be the cause of these errors?

Nothing need to be done.

They are usually happening because of one of two things:

1) The other host computed an incorrect checksum.
2) Something between the foreign host and your's corrupted
   the packet.

Both of which are normal events and so you can ignore the
message safely.
