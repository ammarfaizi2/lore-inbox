Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263304AbUF3XtT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263304AbUF3XtT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 19:49:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263309AbUF3XtT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 19:49:19 -0400
Received: from outmail1.freedom2surf.net ([194.106.33.237]:24496 "EHLO
	outmail.freedom2surf.net") by vger.kernel.org with ESMTP
	id S263304AbUF3XtS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 19:49:18 -0400
Date: Thu, 1 Jul 2004 00:48:47 +0100
From: Ian Molton <spyro@f2s.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: A question about PROT_NONE on ARM and ARM26
Message-Id: <20040701004847.3b7a173b.spyro@f2s.com>
In-Reply-To: <20040630233014.GC32560@mail.shareable.org>
References: <20040630024434.GA25064@mail.shareable.org>
	<20040630091621.A8576@flint.arm.linux.org.uk>
	<20040630145942.GH29285@mail.shareable.org>
	<20040630192654.B21104@flint.arm.linux.org.uk>
	<20040630191428.GC31064@mail.shareable.org>
	<20040630202313.A1496@flint.arm.linux.org.uk>
	<20040630201546.GD31064@mail.shareable.org>
	<20040630235921.C1496@flint.arm.linux.org.uk>
	<20040630233014.GC32560@mail.shareable.org>
Organization: The Dragon Roost
X-Mailer: Sylpheed version 0.9.12-gtk2-20040617 (GTK+ 2.4.1; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Jul 2004 00:30:14 +0100
Jamie Lokier <jamie@shareable.org> wrote:

> "ge" is a signed comparison, and unsigned is needed here, unless I
> missed something subtle.  So "bge" and "ldrge" should be "bhi" and "ldrhi".

technically, I think you're right here.

in practise, the arm26 address space is too small (64MB) for this to
ever cause a problem.
