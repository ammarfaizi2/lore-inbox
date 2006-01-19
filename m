Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161100AbWASA2N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161100AbWASA2N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 19:28:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161098AbWASA2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 19:28:13 -0500
Received: from mx1.suse.de ([195.135.220.2]:34962 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161096AbWASA2M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 19:28:12 -0500
From: Neil Brown <neilb@suse.de>
To: Kyle Moffett <mrmacman_g4@mac.com>
Date: Thu, 19 Jan 2006 11:28:05 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17358.56597.418773.34768@cse.unsw.edu.au>
Cc: Michael Tokarev <mjt@tls.msk.ru>, sander@humilis.net,
       linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
       "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: Re: [PATCH 000 of 5] md: Introduction
In-Reply-To: message from Kyle Moffett on Tuesday January 17
References: <20060117174531.27739.patches@notabene>
	<43CCA80B.4020603@tls.msk.ru>
	<20060117095019.GA27262@localhost.localdomain>
	<43CCD453.9070900@tls.msk.ru>
	<B6E0BCA1-5F60-431F-8A29-9B36D3A05413@mac.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday January 17, mrmacman_g4@mac.com wrote:
> On Jan 17, 2006, at 06:26, Michael Tokarev wrote:
> > This is about code complexity/bloat.  It's already complex enouth.  
> > I rely on the stability of the linux softraid subsystem, and want  
> > it to be reliable. Adding more features, especially non-trivial  
> > ones, does not buy you bugfree raid subsystem, just the opposite:  
> > it will have more chances to crash, to eat your data etc, and will  
> > be harder in finding/fixing bugs.
> 
> What part of: "You will need to enable the experimental  
> MD_RAID5_RESHAPE config option for this to work." isn't bvious?  If  
> you don't want this feature, either don't turn on  
> CONFIG_MD_RAID5_RESHAPE, or don't use the raid5 mdadm reshaping  
> command.

This isn't really a fair comment.  CONFIG_MD_RAID5_RESHAPE just
enables the code.  All the code is included whether this config option
is set or not.  So if code-bloat were an issue, the config option
wouldn't answer it.

NeilBrown
