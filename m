Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261390AbSJDHCW>; Fri, 4 Oct 2002 03:02:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261509AbSJDHCW>; Fri, 4 Oct 2002 03:02:22 -0400
Received: from mailout04.sul.t-online.com ([194.25.134.18]:58282 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261390AbSJDHCV> convert rfc822-to-8bit; Fri, 4 Oct 2002 03:02:21 -0400
Content-Type: text/plain; charset=US-ASCII
From: Hasch@t-online.de (Juergen Hasch)
To: Christian Reis <kiko@async.com.br>, NFS@lists.sourceforge.net
Subject: Re: [NFS] 2.4.19+trond and diskless locking problems
Date: Fri, 4 Oct 2002 09:07:47 +0200
X-Mailer: KMail [version 1.4]
Cc: linux-kernel@vger.kernel.org
References: <20021003184418.K3869@blackjesus.async.com.br>
In-Reply-To: <20021003184418.K3869@blackjesus.async.com.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210040907.47257.hasch@t-online.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 3. Oktober 2002 23:44 schrieb Christian Reis:
>
> We also occasionally get a log message in the server for this box like:
>
>     kernel:Aug 10 17:39:22 anthem kernel: lockd: cannot monitor
> 192.168.99.7

I got the same messages when mounting an AIX client to a Linux server after 
upgrading to 2.4.19 Kernel.
After installing the latest NFS utils, the problem went away.
So I guess Trond is right, try looking at the userspace utilities.

...Juergen

