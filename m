Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266917AbUBFVwS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 16:52:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266485AbUBFVwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 16:52:16 -0500
Received: from letku14.adsl.netsonic.fi ([194.29.195.14]:11674 "EHLO
	tupa.firmament.fi") by vger.kernel.org with ESMTP id S265629AbUBFVvA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 16:51:00 -0500
Date: Fri, 6 Feb 2004 23:46:45 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Limit hash table size
Message-ID: <20040206214645.GA20608@firmament.fi>
References: <B05667366EE6204181EABE9C1B1C0EB5802441@scsmsx401.sc.intel.com.suse.lists.linux.kernel> <20040205155813.726041bd.akpm@osdl.org.suse.lists.linux.kernel> <p73isilkm4x.fsf@verdi.suse.de> <20040205190904.0cacd513.akpm@osdl.org> <20040206202006.GA19473@firmament.fi> <20040206122752.4dc9f434.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040206122752.4dc9f434.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
From: =?iso-8859-1?Q?Taneli_V=E4h=E4kangas?= <taneli@firmament.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 06, 2004 at 12:27:52PM -0800, Andrew Morton wrote:
> Taneli Vähäkangas <taneli@firmament.fi> wrote:
> >
> > OTOH, I'd very much
> > appreciate if the system didn't act very sluggish during updatedb.
> 
> It really helps if your filesystems were laid out by a 2.6 kernel.  What
> usually happens at present is that you install the distro using a 2.4
> kernel and then install 2.6.  So all those files under /usr/bin and
> /usr/include and everywhere else are laid down by the 2.4 kernel.

Actually, I just moved my root and /usr partitions to another hard drive
on Monday using tar on the same 2.6 system. Should that have helped? I
didn't notice any improvement, but the new drive may be a little slower
(its about the same age (6 years?) and capacity (4G), but from a laptop).
Maybe I should move also /home over and see if it improves? It is 4 and
a half years old, and probably made with 2.2 kernel. That will require a
little more effort, since I don't have a replacement HD.

	Taneli

