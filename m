Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264749AbSK0UYj>; Wed, 27 Nov 2002 15:24:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264756AbSK0UYj>; Wed, 27 Nov 2002 15:24:39 -0500
Received: from pat.uio.no ([129.240.130.16]:56464 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S264749AbSK0UYi>;
	Wed, 27 Nov 2002 15:24:38 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15845.11182.384531.599421@charged.uio.no>
Date: Wed, 27 Nov 2002 21:31:42 +0100
To: Christian Reis <kiko@async.com.br>
Cc: NFS@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19+trond and diskless locking problems
In-Reply-To: <20021127150828.A12120@blackjesus.async.com.br>
References: <20021003184418.K3869@blackjesus.async.com.br>
	<shsy99f16np.fsf@charged.uio.no>
	<20021003202602.M3869@blackjesus.async.com.br>
	<15772.60202.510717.850059@charged.uio.no>
	<20021120120223.A15034@blackjesus.async.com.br>
	<15835.49194.109931.227732@charged.uio.no>
	<20021126224123.A9660@blackjesus.async.com.br>
	<15844.7306.735524.133781@charged.uio.no>
	<20021127150828.A12120@blackjesus.async.com.br>
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Christian Reis <kiko@async.com.br> writes:

     > What can I do to help further debug the issue? Try another
     > kernel version on clients? Server? This is giving me a
     > headache.. :-/

Try to give us a dump of the server lock manager activity when this
problem occurs. Try to do

echo "217" >/proc/sys/sunrpc/nlm_debug

on the server just before the client issues a lock.

Cheers,
  Trond
