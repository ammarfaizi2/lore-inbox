Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264505AbUFXNDJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264505AbUFXNDJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 09:03:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264409AbUFXM6z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 08:58:55 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:35318 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S264502AbUFXM4z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 08:56:55 -0400
Date: Thu, 24 Jun 2004 13:56:48 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: "Vladimir V. Saveliev" <vs@namesys.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.7-mm[12]] kernel BUG at include/linux/list.h:164!
In-Reply-To: <40DABE5A.6040603@namesys.com>
Message-ID: <Pine.LNX.4.44.0406241347590.13778-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jun 2004, Vladimir V. Saveliev wrote:
> 
> It appears regularly when I try to compile 
> http://thebsh.namesys.com/snapshots/2004.03.26/reiser4progs-0.5.3.tar.gz
> 
> Well, on 2.6.7-mm1 it breaks easier. on 2.6.7-mm2 - it manages to 
> compelte once.
> 
> (gdb) bt
> #0  0xc013c75a in anon_vma_unlink (vma=0xcdb7a3c0) at 
> include/linux/list.h:164
> Cannot access memory at address 0xc013c738
> 
> Has anyone ever seen something similar? Is there workaround already?

Haven't seen or heard of that, no, so no workaround yet.
The finger of blame points to me, but I don't know what's up.

> I would be glad to perform any tests to help fixing this

Thank you, much appreciated.  Let's leave lkml off for now (don't
want my foolishness exposed to public gaze!), I'll mail you privately.

Hugh

