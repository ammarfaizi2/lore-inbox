Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261595AbTJ2URn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 15:17:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261601AbTJ2URn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 15:17:43 -0500
Received: from gprs194-254.eurotel.cz ([160.218.194.254]:54915 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261595AbTJ2URm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 15:17:42 -0500
Date: Wed, 29 Oct 2003 21:17:31 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Ben Collins <bcollins@debian.org>
Cc: Matthew J Galgoci <mgalgoci@parcelfarce.linux.theplanet.co.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: sbp2 slab corruiton in 2.6-test9
Message-ID: <20031029201731.GB1941@elf.ucw.cz>
References: <Pine.LNX.4.44.0310261357100.16378-100000@parcelfarce.linux.theplanet.co.uk> <20031026141837.GA7904@phunnypharm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031026141837.GA7904@phunnypharm.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I'm seeing slab corruption in 2.6-test9 when I do a 
> > cat /proc/scsi/scsi
> > 
> 
> Known. The fix is non-trivial, so I am holding off on it until 2.6.0
> gets out.

You need to disable /proc/scsi/scsi at least, I guess. Its security
hole...

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
