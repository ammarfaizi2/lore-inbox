Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267414AbTAGQtH>; Tue, 7 Jan 2003 11:49:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267415AbTAGQtH>; Tue, 7 Jan 2003 11:49:07 -0500
Received: from mons.uio.no ([129.240.130.14]:408 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S267414AbTAGQtG>;
	Tue, 7 Jan 2003 11:49:06 -0500
To: Christian Reis <kiko@async.com.br>
Cc: NFS@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: /var/lib/nfs/sm/ files
References: <20030107132743.E2628@blackjesus.async.com.br>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 07 Jan 2003 17:54:59 +0100
In-Reply-To: <20030107132743.E2628@blackjesus.async.com.br>
Message-ID: <shsn0mcj3x8.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Christian Reis <kiko@async.com.br> writes:

     > Hi there,

     > Can `anybody' (Neil, Trond?) explain what the entries in
     > /var/lib/nfs/sm/ are for? If they refer to file locks, can we

'man rpc.statd'. Those files store the IP-addresses of the machines
being monitored by statd. In case of a crash or a reboot, those files
tell statd which machines that need to be notified.

Cheers,
  Trond
