Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315457AbSHaAw1>; Fri, 30 Aug 2002 20:52:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315445AbSHaAw1>; Fri, 30 Aug 2002 20:52:27 -0400
Received: from pat.uio.no ([129.240.130.16]:62936 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S315430AbSHaAw0>;
	Fri, 30 Aug 2002 20:52:26 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15728.5194.587032.289180@charged.uio.no>
Date: Sat, 31 Aug 2002 02:56:42 +0200
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux FSdevel <linux-fsdevel@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Dave McCracken <dmccr@us.ibm.com>
Subject: Re: [PATCH] Introduce BSD-style user credential [3/3]
In-Reply-To: <1030755064.1225.18.camel@irongate.swansea.linux.org.uk>
References: <Pine.LNX.4.44.0208301741430.5561-100000@home.transmeta.com>
	<1030755064.1225.18.camel@irongate.swansea.linux.org.uk>
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

     > Needs fsuid too,

Sorry? 'fsuid' and 'fsgid' are supposed to be represented by the
'struct ucred' (or 'vfs_cred').

Cheers,
  Trond
