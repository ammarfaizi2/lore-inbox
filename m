Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293181AbSCAOPx>; Fri, 1 Mar 2002 09:15:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293189AbSCAOPn>; Fri, 1 Mar 2002 09:15:43 -0500
Received: from brooklyn-bridge.emea.veritas.com ([62.172.234.2]:25303 "EHLO
	einstein.homenet") by vger.kernel.org with ESMTP id <S293181AbSCAOP2>;
	Fri, 1 Mar 2002 09:15:28 -0500
Date: Fri, 1 Mar 2002 14:19:32 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
X-X-Sender: <tigran@einstein.homenet>
To: Joe Wong <joewong@tkodog.no-ip.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: kdb
In-Reply-To: <Pine.LNX.4.21.0203012202120.11280-100000@dog.ima.net>
Message-ID: <Pine.LNX.4.33.0203011416580.2116-100000@einstein.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Mar 2002, Joe Wong wrote:
>   Is there any detailed descriptions on how to use kdb? I would like to
> know if it is possible to display the source code ( as in GDB ) in kdb.

There are some mm pages in Documentation/kdb subdirectory of the
kernel tree (assuming the tree was patched with kdb patch) which you read
like this:

# nroff -man kdb.mm | less

And no, you can't display source code with kdb. To do that use kgdb which
is available from:

http://kgdb.sourceforge.net

Regards,
Tigran

