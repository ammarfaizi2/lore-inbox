Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284263AbRLRQza>; Tue, 18 Dec 2001 11:55:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284272AbRLRQzV>; Tue, 18 Dec 2001 11:55:21 -0500
Received: from ns.suse.de ([213.95.15.193]:36621 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S284263AbRLRQzP>;
	Tue, 18 Dec 2001 11:55:15 -0500
Date: Tue, 18 Dec 2001 17:55:13 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: David Relson <relson@osagesoftware.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.1 - undefined symbols building NFS as a module
In-Reply-To: <4.3.2.7.2.20011218113324.00e657e0@mail.osagesoftware.com>
Message-ID: <Pine.LNX.4.33.0112181754150.29077-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Dec 2001, David Relson wrote:

> and here's the complaint from "make modules_install"
> if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.1; fi
> depmod: *** Unresolved symbols in /lib/modules/2.5.1/kernel/fs/nfs/nfs.o
> depmod: 	seq_escape
> depmod: 	seq_printf

Fixed in -dj3 (url in other mail).
(If you don't want it all, just take the hunk that
 adds exports of these functions)

Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

