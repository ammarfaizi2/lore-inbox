Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262154AbUCaRQs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 12:16:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262080AbUCaRQr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 12:16:47 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:37562 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S262272AbUCaRLx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 12:11:53 -0500
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFS ENOLCK problem with CONFIG_SECURITY=n
References: <527jx1atuu.fsf@topspin.com>
	<1080751099.4194.23.camel@lade.trondhjem.org>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 31 Mar 2004 09:11:51 -0800
In-Reply-To: <1080751099.4194.23.camel@lade.trondhjem.org>
Message-ID: <52r7v99c14.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 31 Mar 2004 17:11:52.0055 (UTC) FILETIME=[42956070:01C41743]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Trond> Error 13 == EPERM means "permission denied". Check that you
    Trond> haven't misconfigured your /etc/hosts.deny file to deny
    Trond> access to portmap/rpc.statd from localhost/your client on
    Trond> your server/your server on your client...

Even worse than that... Debian by default doesn't install its
"nfs-common" package, so I had no statd running.  Duh.

Sorry for the noise,
  Roland
