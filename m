Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267895AbTAMFrq>; Mon, 13 Jan 2003 00:47:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267874AbTAMFrq>; Mon, 13 Jan 2003 00:47:46 -0500
Received: from [207.88.206.43] ([207.88.206.43]:39562 "EHLO
	intruder-luxul.gurulabs.com") by vger.kernel.org with ESMTP
	id <S267897AbTAMFrn>; Mon, 13 Jan 2003 00:47:43 -0500
Subject: Re: [PATCH] Secure user authentication for NFS using RPCSEC_GSS
	[0/6]
From: Dax Kelson <Dax.Kelson@gurulabs.com>
To: trond.myklebust@fys.uio.no
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       NFS maillist <nfs@lists.sourceforge.net>
In-Reply-To: <15906.1154.649765.791797@charged.uio.no>
References: <15906.1154.649765.791797@charged.uio.no>
Content-Type: text/plain
Organization: Guru Labs
Message-Id: <1042437391.1677.8.camel@thud>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 12 Jan 2003 22:56:31 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-01-12 at 17:12, Trond Myklebust wrote:
> Hi Linus,
> 
>  The following set of 6 patches implements support for the RPCSEC_GSS
> security protocol (authentication only) and the Kerberos V5 security
> mechanism.

As a user and sysadmin, I've been waiting for this for a LONG time.
Standard NFS security/authentication sucks rocks. Without this NFS home
directory servers are just waiting to be ransacked by a rouge (or
compromised) root user on a client machine.

NFSv4 w/RPSEC_GSS is finally a native UNIX filesharing solution that I
don't have to be ashamed of when hanging with admins of those "other
OSes".

Dax

