Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750754AbWIMJxZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754AbWIMJxZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 05:53:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751391AbWIMJxZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 05:53:25 -0400
Received: from main.gmane.org ([80.91.229.2]:63441 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750754AbWIMJxY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 05:53:24 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: David Abrahams <dave@boost-consulting.com>
Subject: Re: [ltp] 2.6.18-rc6, SATA, resume from RAM
Date: Wed, 13 Sep 2006 05:52:55 -0400
Message-ID: <87hczcytxk.fsf@pereiro.luannocracy.com>
References: <87u03dcmfc.fsf@pereiro.luannocracy.com> <20060912132838.GQ7767@gimli>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 216-15-125-177.c3-0.smr-ubr3.sbo-smr.ma.cable.rcn.com
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.0 (gnu/linux)
Cancel-Lock: sha1:anpVX8TVgVrpkzz8jCx4sb9LXMI=
Cc: linux-thinkpad@linux-thinkpad.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Lorenz <martin@lorenz.eu.org> writes:

> On Tue, Sep 12, 2006 at 08:13:43AM -0400, David Abrahams wrote:
>> 
>> Since installing a 2.6.18-rc6 kernel, my Thinkpad T60P's SATA hard
>> drive doesn't seem to spin up when resuming from a suspend-to-RAM.  Am
>> I missing something obvious, is this a kernel bug, or am I missing
>> something less-obvious ;-)?
>
> I don't know if your T60 has the same issue like my X60s but I had to patch
> my kernel to get a proper resume

Hm.  The resume on ubuntu's stock kernel worked for me.
Does your X60s have an SATA hard drive?

> I applied forrest zhauo's set of ahci patches to 2.6.18-rc5
>
> you find those patches here:
> http://marc.theaimsgroup.com/?l=linux-ide&m=115277002327654&w=2
>
> maybe they find there way into the kernel sometime :-)

I'll try that out, thanks.  Hm.  It's not clear which of these patches
are the real final versions.  There appears to be some criticism of
his implementation
(http://marc.theaimsgroup.com/?l=linux-ide&m=115334269706716&w=2) and
resending
(http://article.gmane.org/gmane.linux.ide/12210)
going on later on the same list.

And then there is a reimplementation of the same work...
http://article.gmane.org/gmane.linux.ide/12266

Maybe I'll try that latter set.  Thanks for the pointer.

-- 
Dave Abrahams
Boost Consulting
www.boost-consulting.com

