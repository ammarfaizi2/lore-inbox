Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261325AbUL2GE0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261325AbUL2GE0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 01:04:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261327AbUL2GE0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 01:04:26 -0500
Received: from sweetums.bluetronic.net ([24.199.150.42]:7823 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id S261325AbUL2GEY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 01:04:24 -0500
Date: Wed, 29 Dec 2004 01:00:31 -0500 (EST)
From: Ricky Beam <jfbeam@bluetronic.net>
To: Kyle Moffett <mrmacman_g4@mac.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BK] disconnected operation
In-Reply-To: <C8A13912-5958-11D9-AA77-000393ACC76E@mac.com>
Message-ID: <Pine.GSO.4.33.0412290052030.6921-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Dec 2004, Kyle Moffett wrote:
>So what would happen to somebody who put their BK files on a portable
>drive and carried it from home to work.  That's a perfectly reasonable
>thing to do, both for security and for speed reasons, but it would appear
>to cause problems.

First, the license(s) are stored in the user's home directory (~/.bk/lease)
per hostname.  If you move to a completely different machine, then, yes,
there will need to be a lease for that machine.

What you are describing is no different from the NFS case.  It doesn't
matter that the media has physically moved; it's still visible to multiple,
unique hosts.  Each host(name) will need it's own lease.

--Ricky


