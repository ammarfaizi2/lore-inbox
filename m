Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264292AbUAEMYQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 07:24:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264310AbUAEMYQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 07:24:16 -0500
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:17707 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S264292AbUAEMYO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 07:24:14 -0500
Date: Mon, 5 Jan 2004 07:23:57 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Christophe Saout <christophe@saout.de>
cc: neel vanan <neelvanan@yahoo.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Kernel panic.. in 3.0 Enterprise Linux
In-Reply-To: <1073304533.5562.7.camel@leto.cs.pocnet.net>
Message-ID: <Pine.LNX.4.44.0401050722520.23604-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Jan 2004, Christophe Saout wrote:
> Am Mo, den 05.01.2004 schrieb neel vanan um 12:56:
> 
> > VFS cannot open root device "LABEL=/" or unknown block
> > (0,0)
> > Please append a correct "root=" boot option
> > Kernel panic: VFS: Unable to mount root fs on
> > unknown-block(0,0)
> 
> LABEL= is a RedHat extension. Please use the normal root options that is
> described in the Grub or kernel documentation.

It's not even a Red Hat extension.  The LABEL= stuff is
done entirely in userspace, on the initrd.

If you do not want to use an initrd, you need to use the
normal root options instead, something like root=/dev/hda3

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

