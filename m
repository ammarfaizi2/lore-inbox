Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261919AbTFINlx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 09:41:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261944AbTFINlx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 09:41:53 -0400
Received: from 216-239-45-4.google.com ([216.239.45.4]:23371 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S261919AbTFINlx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 09:41:53 -0400
Date: Mon, 9 Jun 2003 06:55:23 -0700
From: Frank Cusack <fcusack@fcusack.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>, torvalds@transmeta.com,
       marcelo@conectiva.com.br
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nfs_unlink() race (was: nfs_refresh_inode: inode number mismatch)
Message-ID: <20030609065523.B9781@google.com>
References: <20030603165438.A24791@google.com> <shswug2sz5x.fsf@charged.uio.no> <20030604142047.C24603@google.com> <16094.25720.895263.4398@charged.uio.no> <20030603165438.A24791@google.com> <20030609065141.A9781@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030609065141.A9781@google.com>; from fcusack@fcusack.com on Mon, Jun 09, 2003 at 06:51:41AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Forgot to mention, this affects NFSv3 only.  Maybe because NFSv2 doesn't
have the cookie verifier and so readdir() always restarts?  Something
like that.

/fc
