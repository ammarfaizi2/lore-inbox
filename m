Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262366AbTJOFKW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 01:10:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262419AbTJOFKW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 01:10:22 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:46563 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S262366AbTJOFKS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 01:10:18 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: "Bryan O'Sullivan" <bos@serpentine.com>
Date: Wed, 15 Oct 2003 15:10:10 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16268.54962.351518.471251@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Strange dcache memory pressure when highmem enabled
In-Reply-To: message from Bryan O'Sullivan on Tuesday October 14
References: <16268.52761.907998.436272@notabene.cse.unsw.edu.au>
	<1066194345.16993.12.camel@camp4.serpentine.com>
X-Mailer: VM 7.17 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday October 14, bos@serpentine.com wrote:
> On Tue, 2003-10-14 at 21:33, Neil Brown wrote:
> 
> >  I have a fairly busy NFS server which has been having performance
> >  problems lately.  I have managed to work around the problems, but
> >  would really like to get the root problem fixed.
> 
> Funny, I have seen exactly the same problem, though with a Red Hat
> 2.4.20 kernel, rather than a vanilla-ish 2.4.
> 
> I have a few thousand more entries in my dentry cache on a 2G machine,
> but it's still a pitiful number.
> 
> What workarounds did you find?

 I just boot with "mem=900M" and effectively removed the highmem.
 It's not ideal, but it is the best I have found.

NeilBrown
