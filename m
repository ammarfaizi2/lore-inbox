Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261646AbSKCFbR>; Sun, 3 Nov 2002 00:31:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261650AbSKCFbR>; Sun, 3 Nov 2002 00:31:17 -0500
Received: from [207.88.206.43] ([207.88.206.43]:36483 "EHLO
	intruder-luxul.gurulabs.com") by vger.kernel.org with ESMTP
	id <S261646AbSKCFbR>; Sun, 3 Nov 2002 00:31:17 -0500
Subject: Re: Filesystem Capabilities in 2.6?
From: Dax Kelson <dax@gurulabs.com>
To: andersen@codepoet.org
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20021103053109.GA19281@codepoet.org>
References: <Pine.GSO.4.21.0211022114280.25010-100000@steklov.math.psu.edu>
	<Pine.LNX.4.44.0211022101090.20616-100000@mooru.gurulabs.com> 
	<20021103053109.GA19281@codepoet.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 02 Nov 2002 22:37:48 -0700
Message-Id: <1036301868.31698.160.camel@thud>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-11-02 at 22:31, Erik Andersen wrote:
> On Sat Nov 02, 2002 at 09:04:07PM -0700, Dax Kelson wrote:
> >
> > 
> > Any thoughts on how /usr/bin/(rpm|dpkg) copes with setting up the binding
> > when installing a package?
> 
> postint script

Sure, but editing /etc/fstab from postint is messy, potentially
dangerous, and could possibly collide with someone doing a manual edit
of /etc/fstab.

Maybe we need a /etc/fstab.d/ directory and teach /bin/mount about it.

