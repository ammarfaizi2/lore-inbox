Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263903AbUCZA44 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 19:56:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263878AbUCZAyR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 19:54:17 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64981 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263887AbUCZAdl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 19:33:41 -0500
Date: Fri, 26 Mar 2004 00:33:39 +0000
From: Matthew Wilcox <willy@debian.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Adrian Bunk <bunk@fs.tum.de>, 239952@bugs.debian.org,
       debian-devel@lists.debian.org, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: Binary-only firmware covered by the GPL?
Message-ID: <20040326003339.GD25059@parcelfarce.linux.theplanet.co.uk>
References: <E1B6Izr-0002Ai-00@r063144.stusta.swh.mhn.de> <20040325082949.GA3376@gondor.apana.org.au> <20040325220803.GZ16746@fs.tum.de> <40635DD9.8090809@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40635DD9.8090809@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2004 at 05:31:53PM -0500, Jeff Garzik wrote:
> 
> Well IANAL, but it seems not so cut-n-dried, at least.
> 
> Firmware is a program that executes on another processor, so no linking 
> is taking place at all.  It is analagous to shipping a binary-only 
> program in your initrd, IMO.

Linking isn't the issue.  I went and read the original bug on this a
while back.  The issue is that it's a program that's distributed in
binary form without source code.  That's forbidden from being in main
by the terms of the Debian Social Contract.

I realise there's a grey area between "magic data you write to a device"
and "a program that is executed on a different processor".  For example,
palette data for a frame buffer.  But nobody's arguing for that grey
area here -- it's clearly a program without source code that Debian
can't distribute.

I think this is a terribly unfortunate state of affairs and I'm not happy
about how it's been handled or communicated.  I'd really appreciate it
if someone managed to think of a good solution to this.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
