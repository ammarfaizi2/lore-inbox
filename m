Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262770AbTCVNfr>; Sat, 22 Mar 2003 08:35:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262771AbTCVNfr>; Sat, 22 Mar 2003 08:35:47 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:40089
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262770AbTCVNfq>; Sat, 22 Mar 2003 08:35:46 -0500
Subject: Re: 2.4+ptrace exploit fix breaks root's ability to strace
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030322103121.A16994@flint.arm.linux.org.uk>
References: <20030322103121.A16994@flint.arm.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048345130.8912.9.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 22 Mar 2003 14:58:51 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-03-22 at 10:31, Russell King wrote:
> Hi,
> 
> Are the authors of the ptrace patch aware that, in addition to closing the
> hole, the "fix" also prevents a ptrace-capable task (eg, strace started by
> root) from ptracing user threads?
> 
> For example, you can't strace vsftpd processes started from xinetd.
> 
> Is this intended behaviour?

Its an unintended side effect, nobody has sent a patch to fix it yet.

