Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270863AbTHDAwZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 20:52:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271352AbTHDAwZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 20:52:25 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:23736 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S270863AbTHDAwY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 20:52:24 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Steve Dickson <SteveD@RedHat.com>
Date: Mon, 4 Aug 2003 10:52:12 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16173.44604.327927.223153@gargle.gargle.HOWL>
Cc: Neil Brown <neilb@cse.unsw.edu.au>, nfs@lists.sourceforge.net,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Chip Salzenberg <chip@pobox.com>, Andrew Morton <akpm@osdl.org>,
       Rik van Riel <riel@RedHat.com>
Subject: Re: nfs-utils-1.0.5 is not backwards compatible with 2.4
In-Reply-To: message from Steve Dickson on Friday August 1
References: <3F294DE3.9020304@RedHat.com>
	<16169.54918.472349.928145@gargle.gargle.HOWL>
	<3F2A6087.3060801@RedHat.com>
X-Mailer: VM 7.17 under Emacs 21.3.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday August 1, SteveD@RedHat.com wrote:
> I see your point...  I guess I didn't realize that  the "nohide" option  
> (that the user
> sees) has been using the NFSEXP_CROSSMNT define this whole time....
> 
> And I also agree with you if somebody is directly using the bits instead of
> the "nohide" ascii representation they are on there own since there is no
> real export API per say....
> 
> But just to make the clean up complete, wouldn't the attached patch be
> needed in the 2.4 kernel if  nfs-utils-1.0.5 was going to be used?

It wouldn't hurt, but it certainly isn't needed (as it doesn't
actually change any bit of compiled code).

I will put it on my list to send for 2.4.23-pre

NeilBrown
