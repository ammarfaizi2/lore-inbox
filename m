Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267124AbTAFTlp>; Mon, 6 Jan 2003 14:41:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267128AbTAFTlp>; Mon, 6 Jan 2003 14:41:45 -0500
Received: from ns.suse.de ([213.95.15.193]:59918 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S267124AbTAFTlp>;
	Mon, 6 Jan 2003 14:41:45 -0500
Date: Mon, 6 Jan 2003 20:50:22 +0100
From: Olaf Kirch <okir@suse.de>
To: Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix NFS IRIX compatibility braindamage
Message-ID: <20030106195021.GD8269@suse.de>
References: <200210291208.g9TC8s305165@hera.kernel.org> <20030106193320.GD16489@codemonkey.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20030106193320.GD16489@codemonkey.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 06, 2003 at 07:33:20PM +0000, Dave Jones wrote:
> I'm going through the old 2.4 changelogs looking for bits that
> have been missed out, the little one liners have been going
> direct to Linus/maintainer, but here's the first one I'm
> unsure of..
> 
> Any reason this is missing in 2.5 ?

I think I sent it to the NFS mailing list and forgot about it
afterwards.

The problem this patch tries to address is that the current code allows
diskless clients to chmod device files, even when the directory is
exported read-only.

Olaf
-- 
Olaf Kirch     |  Anyone who has had to work with X.509 has probably
okir@suse.de   |  experienced what can best be described as
---------------+  ISO water torture. -- Peter Gutmann
