Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262864AbTKCUM0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 15:12:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262937AbTKCUM0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 15:12:26 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:43494 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S262864AbTKCUMZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 15:12:25 -0500
Date: Mon, 3 Nov 2003 21:12:23 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Valdis.Kletnieks@vt.edu
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: how to restart userland?
Message-ID: <20031103201223.GC16820@louise.pinerecords.com>
References: <20031103193940.GA16820@louise.pinerecords.com> <200311032003.hA3K3tgv017273@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200311032003.hA3K3tgv017273@turing-police.cc.vt.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov-03 2003, Mon, 15:03 -0500
Valdis.Kletnieks@vt.edu <Valdis.Kletnieks@vt.edu> wrote:

> On Mon, 03 Nov 2003 20:39:40 +0100, Tomas Szepe <szepe@pinerecords.com>  said:
> > Would anyone know of a proven way to completely restart the userland
> > of a Linux system?
> 
> This would be distinct from 'shutdown -r' how?

No reboot.

> Is there a reason you want to "completely" restart userland and *not*
> reboot (for instance, wanting to keep existing mounts, etc)?

Extensive userland upgrades (glibc is a nice example I guess), etc.

> A case could be made that for a "complete" restart, you need to trash
> those mounts too (if you're restarting to get a 'clean' setup, you want
> to actually be clean), and so forth.

Right.

-- 
Tomas Szepe <szepe@pinerecords.com>
