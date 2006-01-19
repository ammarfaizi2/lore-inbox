Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161101AbWASAdD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161101AbWASAdD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 19:33:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161098AbWASAdD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 19:33:03 -0500
Received: from ns.suse.de ([195.135.220.2]:51859 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161097AbWASAdA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 19:33:00 -0500
From: Neil Brown <neilb@suse.de>
To: sander@humilis.net
Date: Thu, 19 Jan 2006 11:32:53 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17358.56885.928063.466619@cse.unsw.edu.au>
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
       "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: Re: [PATCH 005 of 5] md: Final stages of raid5 expand code.
In-Reply-To: message from Sander on Tuesday January 17
References: <20060117174531.27739.patches@notabene>
	<1060117065635.27881@suse.de>
	<20060117095531.GB27262@localhost.localdomain>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday January 17, sander@humilis.net wrote:
> NeilBrown wrote (ao):
> > +config MD_RAID5_RESHAPE
> 
> Would this also be possible for raid6?


Yes.  The will follow once raid5 is reasonably reliable.  It is
essentially the same change to a different file.
(One day we will merge raid5 and raid6 together into the one module,
but not today).

> > +          This option allows this restiping to be done while the array
>                                      ^^^^^^^^^
>                                      restriping
> > +	  Please to NOT use it on valuable data with good, tested, backups.
>                  ^^                             ^^^^
>                  do                             without

Thanks * 3.

> 
> Thanks a lot for this feature. I'll try to find a spare computer to test
> this on. Thanks!

That would be great!

NeilBrown
