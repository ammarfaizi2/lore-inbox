Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261550AbSKTQzs>; Wed, 20 Nov 2002 11:55:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261561AbSKTQzs>; Wed, 20 Nov 2002 11:55:48 -0500
Received: from pat.uio.no ([129.240.130.16]:51950 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S261550AbSKTQzr>;
	Wed, 20 Nov 2002 11:55:47 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15835.49194.109931.227732@charged.uio.no>
Date: Wed, 20 Nov 2002 18:02:34 +0100
To: Christian Reis <kiko@async.com.br>
Cc: NFS@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19+trond and diskless locking problems
In-Reply-To: <20021120120223.A15034@blackjesus.async.com.br>
References: <20021003184418.K3869@blackjesus.async.com.br>
	<shsy99f16np.fsf@charged.uio.no>
	<20021003202602.M3869@blackjesus.async.com.br>
	<15772.60202.510717.850059@charged.uio.no>
	<20021120120223.A15034@blackjesus.async.com.br>
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Christian Reis <kiko@async.com.br> writes:

     > I haven't forgotten this. It's just that I've been unable to
     > test: the problem just stopped showing up when I upgraded to
     > 2.4.20-pre11 with your NFS-ALL patches applied to it. Could
     > something have changed, or are we just lucky?

The main changes have been the discovery of a couple of kmap()
imbalances. Those are also fixed in 2.4.20-rc2.

Cheers,
  Trond
