Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264211AbUFCB1K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264211AbUFCB1K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 21:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264238AbUFCB1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 21:27:10 -0400
Received: from cantor.suse.de ([195.135.220.2]:31406 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264211AbUFCB1I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 21:27:08 -0400
Date: Thu, 3 Jun 2004 03:27:04 +0200
From: Andi Kleen <ak@suse.de>
To: Joel Becker <Joel.Becker@oracle.com>
Cc: arjanv@redhat.com, torvalds@osdl.org, mingo@elte.hu,
       linux-kernel@vger.kernel.org, akpm@osdl.org, suresh.b.siddha@intel.com,
       jun.nakajima@intel.com
Subject: Re: [announce] [patch] NX (No eXecute) support for x86,
 2.6.7-rc2-bk2
Message-Id: <20040603032704.166b2197.ak@suse.de>
In-Reply-To: <20040603011253.GD5953@ca-server1.us.oracle.com>
References: <20040602205025.GA21555@elte.hu>
	<Pine.LNX.4.58.0406021411030.3403@ppc970.osdl.org>
	<20040602211714.GB29687@devserv.devel.redhat.com>
	<20040603011253.GD5953@ca-server1.us.oracle.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jun 2004 18:12:53 -0700
Joel Becker <Joel.Becker@oracle.com> wrote:

> On Wed, Jun 02, 2004 at 11:17:14PM +0200, Arjan van de Ven wrote:
> > On Wed, Jun 02, 2004 at 02:13:13PM -0700, Linus Torvalds wrote:
> > > Just out of interest - how many legacy apps are broken by this? I assume 
> > > it's a non-zero number, but wouldn't mind to be happily surprised.
> > 
> > based on execshield in FC1.. about zero.
> 
> 	Doesn't Sun's JDK break here?

Nope, since it doesn't have the ELF header bit set that says it can support
that.

-Andi
