Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422760AbWJRS1j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422760AbWJRS1j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 14:27:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422763AbWJRS1j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 14:27:39 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:12135 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1422762AbWJRS1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 14:27:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=bIQJfVZ96MYV3R2qmANtmS0ELHb9qH0QEh1V7w1tw0q87bLzZ2uu8IDCv+0BeAtPeDB7eWFwdOKLJiETIeGWCaLrBBlBSWPyTPRfgWSnEOQ711S2iaVXPgYjxHfYDXVMneuZbbOa/0zu+ZBth7s78der8fynFLj8kuiOTng5GC4=
Message-ID: <45367211.7060802@gmail.com>
Date: Wed, 18 Oct 2006 11:27:29 -0700
From: David KOENIG <karhudever@gmail.com>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Albert Cahalan <acahalan@gmail.com>
Subject: Re: sysctl
References: <787b0d920610181123q1848693ajccf7a91567e54227@mail.gmail.com>
In-Reply-To: <787b0d920610181123q1848693ajccf7a91567e54227@mail.gmail.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Albert Cahalan wrote:
> In the wireless-extensions thread, Linus writes:
> 
>> In general, the answer to "when can we break user space" is very simple.
>>
>> Never.
>>
>> It's just not acceptable. We maintain old interfaces for years (and in
>> some cases, well over a decade by now), simply because the pain from not
>> doing so is horrendous, and it makes debugging impossible. You get into
>> situations where users need to upgrade to tools that don't work with
>> older
>> kernels, and can thus not downgrade, etc etc.
> 
> I guess the sysctl question has been answered then,
> especially since random normal apps use sysctl.
> 
> If it needs a maintainer, put me down.
> 
> I think the main problem was fixed long ago,
> by assigning fixed numbers to the enum values.
> Practically no other kernel code uses an enum
> for an ABI, and I think we can see why.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
How about rewriting sysctl so that it refers to the real way (with /proc)?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFNnIQmhCgVPlWJY8RAiTCAKDUtO4L7XqWo7+vC2vlhltdcb/L3ACfXSeM
Ii48VQu3334MkrGc23StPSA=
=pcCo
-----END PGP SIGNATURE-----
