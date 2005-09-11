Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750979AbVIKWZt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750979AbVIKWZt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 18:25:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750985AbVIKWZs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 18:25:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:1951 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750977AbVIKWZs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 18:25:48 -0400
Date: Sun, 11 Sep 2005 15:25:17 -0700
From: Andrew Morton <akpm@osdl.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: stern@rowland.harvard.edu, linux-kernel@vger.kernel.org
Subject: Re: Elimination of klists
Message-Id: <20050911152517.7a57ba8d.akpm@osdl.org>
In-Reply-To: <1126475059.4831.44.camel@mulgrave>
References: <Pine.LNX.4.44L0.0509111531470.25522-100000@netrider.rowland.org>
	<1126475059.4831.44.camel@mulgrave>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley <James.Bottomley@SteelEye.com> wrote:
>
> Actually, the concept of a klist is quite nice, and the beauty is that
>  all the locking is internal to them, so users can't actually get it
>  wrong (I like interfaces like this).

You're a bit screwed if you want to use them from interrupts..
