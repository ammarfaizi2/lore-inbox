Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262094AbVCCTsf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262094AbVCCTsf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 14:48:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261988AbVCCToe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 14:44:34 -0500
Received: from simmts12.bellnexxia.net ([206.47.199.141]:41188 "EHLO
	simmts12-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261389AbVCCTiG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 14:38:06 -0500
Message-ID: <4737.10.10.10.24.1109878529.squirrel@linux1>
In-Reply-To: <Pine.LNX.4.58.0503030952120.25732@ppc970.osdl.org>
References: <42268749.4010504@pobox.com>
    <20050302200214.3e4f0015.davem@davemloft.net><42268F93.6060504@pobox.com>
    <4226969E.5020101@pobox.com><20050302205826.523b9144.davem@davemloft.net>
    <4226C235.1070609@pobox.com><20050303080459.GA29235@kroah.com>
    <4226CA7E.4090905@pobox.com><Pine.LNX.4.58.0503030750420.25732@ppc970.osdl.org>
    <20050303165533.GQ28536@shell0.pdx.osdl.net><20050303170336.GL19505@suse.de>
    <Pine.LNX.4.58.0503030952120.25732@ppc970.osdl.org>
Date: Thu, 3 Mar 2005 14:35:29 -0500 (EST)
Subject: Re: RFD: Kernel release numbering
From: "Sean" <seanlkml@sympatico.ca>
To: "Linus Torvalds" <torvalds@osdl.org>
Cc: "Jens Axboe" <axboe@suse.de>, "Chris Wright" <chrisw@osdl.org>,
       "Jeff Garzik" <jgarzik@pobox.com>, "Greg KH" <greg@kroah.com>,
       "David S. Miller" <davem@davemloft.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.3a-7
X-Mailer: SquirrelMail/1.4.3a-7
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, March 3, 2005 12:53 pm, Linus Torvalds said:
> On Thu, 3 Mar 2005, Jens Axboe wrote:
>>
>> Why should there be one? One of the things I like about this concept is
>> that it's just a moving tree. There could be daily snapshots like the
>> -bkX "releases" of Linus's tree, if there are changes from the day
>> before. It means (hopefully) that no one will "wait for x.y.z.2 because
>> that is really stable".
>
> Exactly. Th ewhole point of this tree is that there shouldn't be anything
> questionable in it. All the patches are independent, and they are all
> trivial and small.
>
> Which is not to say there couldn't be regressions even from trivial and
> small patches, and yes, there will be an outcry when there is, but we're
> talking minimizing the risk, not making it impossible.
>

Wait a second though, this tree will be branched from the development
mainline.   So it will contain many patches that entered with less
testing.   What will be the policy for dealing with regressions relative
to the previous $sucker release caused by huge patches that entered via
the development tree?   Is reverting them prohibited because of the patch
size?

Sean


