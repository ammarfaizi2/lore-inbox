Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262931AbUDQTJX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 15:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263927AbUDQTJX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 15:09:23 -0400
Received: from adsl-207-214-87-84.dsl.snfc21.pacbell.net ([207.214.87.84]:14721
	"EHLO lade.trondhjem.org") by vger.kernel.org with ESMTP
	id S262931AbUDQTJW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 15:09:22 -0400
Subject: Re: NFS and kernel 2.6.x
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Marc Singer <elf@buici.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040417190107.GA4179@flea>
References: <20040416011401.GD18329@widomaker.com>
	 <1082079061.7141.85.camel@lade.trondhjem.org>
	 <20040415185355.1674115b.akpm@osdl.org>
	 <1082084048.7141.142.camel@lade.trondhjem.org>
	 <20040416045924.GA4870@linuxace.com>
	 <1082093346.7141.159.camel@lade.trondhjem.org>
	 <pan.2004.04.17.16.44.00.630010@smurf.noris.de>
	 <1082225747.2580.18.camel@lade.trondhjem.org> <20040417183219.GB3856@flea>
	 <1082228313.2580.25.camel@lade.trondhjem.org>  <20040417190107.GA4179@flea>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1082228963.2580.34.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 17 Apr 2004 12:09:24 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-04-17 at 12:01, Marc Singer wrote:

> I think you are talking about the fstab mount option.  Is there a
> kernel command line option for this?  That's what I've been looking
> for.  I'm not using an initrd.

No. I'm talking about the built-in parser to enable NFSROOT to pass
mount options. As in:

   nfsroot=[<server-ip>:]<root-dir>[,<nfs-options>]

See Documentation/nfsroot.txt. Put "tcp" as one of the "<nfs-options>",
and your root partition will use TCP instead of UDP.

Cheers,
  Trond
