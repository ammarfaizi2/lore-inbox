Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269124AbTGJINY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 04:13:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269083AbTGJINW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 04:13:22 -0400
Received: from air-2.osdl.org ([65.172.181.6]:51397 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269057AbTGJIK5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 04:10:57 -0400
Date: Thu, 10 Jul 2003 01:25:49 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: marcelo@conectiva.com.br, jgarzik@pobox.com, linux-kernel@vger.kernel.org,
       alan@lxorguk.ukuu.org.uk, torvalds@osdl.org
Subject: Re: RFC:  what's in a stable series?
Message-Id: <20030710012549.7624b397.akpm@osdl.org>
In-Reply-To: <20030710085325.A28672@infradead.org>
References: <3F0CBC08.1060201@pobox.com>
	<Pine.LNX.4.55L.0307100040271.6629@freak.distro.conectiva>
	<20030709211645.40353fc2.akpm@osdl.org>
	<20030710085325.A28672@infradead.org>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:
>
> Especially
>  when just changing a function arg where you only get one more warning in
>  the forrest of warnings produced by gcc 3.3 on a 2.4 tree..

Switching topics (to one of my favourites):

This is a perfect demonstration of why it is utterly unacceptable for
compiler developers to add new warnings without also providing a way of
turning them off.

