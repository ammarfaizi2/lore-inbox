Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422943AbWJRUox@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422943AbWJRUox (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 16:44:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422945AbWJRUox
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 16:44:53 -0400
Received: from pat.uio.no ([129.240.10.4]:7639 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1422943AbWJRUow (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 16:44:52 -0400
Subject: Re: [NFS] NFS inconsistent behaviour
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Chuck Lever <chucklever@gmail.com>
Cc: Frank van Maarseveen <frankvm@frankvm.com>,
       Mohit Katiyar <katiyar.mohit@gmail.com>,
       Linux NFS mailing list <nfs@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
In-Reply-To: <76bd70e30610181317w3e8315e5m75056305904a1bce@mail.gmail.com>
References: <A93BD15112CD05479B1CD204F7F1D4730513DB@exch-04.noida.hcltech.com>
	 <20061016084656.GA13292@janus>
	 <46465bb30610160235m211910b6g2eb074aa23060aa9@mail.gmail.com>
	 <20061016093904.GA13866@janus>
	 <46465bb30610171822h3f747069ge9a170f1759af645@mail.gmail.com>
	 <20061018063945.GA5917@janus> <1161194229.6095.81.camel@lade.trondhjem.org>
	 <20061018183807.GA12018@janus>
	 <1161199580.6095.112.camel@lade.trondhjem.org>
	 <20061018200936.GA14733@janus>
	 <76bd70e30610181317w3e8315e5m75056305904a1bce@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 18 Oct 2006 16:44:35 -0400
Message-Id: <1161204275.6095.143.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.796, required 12,
	autolearn=disabled, AWL 1.20, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-10-18 at 16:17 -0400, Chuck Lever wrote:
> Both client implementations (kernel and glibc) should re-use port
> numbers or connections aggressively.  To that end, the kernel RPC
> client is already doing this.  I know Red Hat has suggested using a
> connection manager for user-level RPC applications to share.  In
> addition the kernel NFS client is sharing connections to a server
> between all mount points going to that server.

IIRC, Mike Waychison did some work a couple of years ago on a userspace
daemon that managed RPC connections.

Cheers,
  Trond

