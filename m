Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263098AbUCMOKy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 09:10:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263099AbUCMOKy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 09:10:54 -0500
Received: from fungus.teststation.com ([212.32.186.211]:30731 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id S263098AbUCMOKx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 09:10:53 -0500
Date: Sat, 13 Mar 2004 15:10:51 +0100 (CET)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: puw@cola.local
To: Nick Warne <nick@ukfsn.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Build problem smbfs/file.c
In-Reply-To: <40530C9D.31619.23368E43@localhost>
Message-ID: <Pine.LNX.4.44.0403131452150.2749-100000@cola.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Mar 2004, Nick Warne wrote:

> PARANOIA("%s/%s validation failed, error=%zd\n"
> 
> Ummm.  I removed the `z' from error=%zd\n" - it appears to be rogue, 
> but what do I know ;)

I think someone meant to change my %d into a %Zd, like in smb_file_read.
Or not, since my gcc's understand them both.

Compiler version?

/Urban

