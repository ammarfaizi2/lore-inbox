Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314707AbSFXSaF>; Mon, 24 Jun 2002 14:30:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314748AbSFXSaE>; Mon, 24 Jun 2002 14:30:04 -0400
Received: from fungus.teststation.com ([212.32.186.211]:33555 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S314707AbSFXSaD>; Mon, 24 Jun 2002 14:30:03 -0400
Date: Mon, 24 Jun 2002 20:29:06 +0200 (CEST)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: puw@cola.enlightnet.local
To: Vasil Kolev <vasil@dobrich.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: SMBFS related oops in 2.4.18
In-Reply-To: <Pine.LNX.4.33.0206241855130.18918-100000@doom.bastun.net>
Message-ID: <Pine.LNX.4.44.0206242020560.9482-100000@cola.enlightnet.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jun 2002, Vasil Kolev wrote:

> This is an oops i got, after smbfs got stuck (and the file server was
> working perfectly) and i killed smbmount, so i can umount it.

It probably got stuck after the oops, and not the other way around.


> Unable to handle kernel paging request at virtual address e0000000
...
> Process du (pid: 13931, stackpage=ce79f000)
...
> >>EIP; c016a6c7 <smb_fill_cache+53/2dc>   <=====

http://www.hojdpunkten.ac.se/054/samba/00-smbfs-2.4.18-codepage.patch.gz

/Urban

