Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280059AbRLDECY>; Mon, 3 Dec 2001 23:02:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278959AbRLDECO>; Mon, 3 Dec 2001 23:02:14 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:41739 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S280084AbRLDEB7>;
	Mon, 3 Dec 2001 23:01:59 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15372.19052.147417.356001@argo.ozlabs.ibm.com>
Date: Tue, 4 Dec 2001 15:00:44 +1100 (EST)
To: Manoj Iyer <manjo@austin.ibm.com>
Cc: kernelmailinglist <linux-kernel@vger.kernel.org>
Subject: Re: PPC 2.4.17.pre2 kernel build breaks!!
In-Reply-To: <Pine.LNX.4.33.0112031626450.2127-100000@lazy>
In-Reply-To: <Pine.LNX.4.33.0112031626450.2127-100000@lazy>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manoj Iyer writes:

> I get the following build break compiling kernel 2.4.17.pre2 on PPC-32.
> Any suggestions??

Unfortunately, kgdb is broken on PPC at the moment.  You can either
remove CONFIG_KGDB from your config or else add an implementation of
getDebugChar and putDebugChar for your hardware.  (If you do, please
send us a patch. :)

What hardware is it, BTW?  You didn't say.

Paul.
