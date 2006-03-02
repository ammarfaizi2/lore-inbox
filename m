Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751350AbWCBBjr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751350AbWCBBjr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 20:39:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751359AbWCBBjr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 20:39:47 -0500
Received: from wproxy.gmail.com ([64.233.184.192]:22973 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751350AbWCBBjq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 20:39:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=X0P5aFHWDoyflTpN+oQ76q+FvhUcTzf0eEbYwb85IPhcrlfGu8XMAzPshdgD+GPkZmOVjGdN1CTAY9nbZtOErRQJASuQiFIBQkQNng+1kMSVwY+yARrVvfsgPs67rE/kNc5wOOXws0ONR6y9azLg3SMxh0SBnF5gu+HWuxK0evM=
Message-ID: <311601c90603011739o47684f4fxa3dc3b5046638655@mail.gmail.com>
Date: Wed, 1 Mar 2006 18:39:45 -0700
From: "Eric D. Mudama" <edmudama@gmail.com>
To: "Nicolas Mailhot" <nicolas.mailhot@gmail.com>
Subject: Re: LibPATA code issues / 2.6.15.4
Cc: "Mark Lord" <liml@rtr.ca>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <311601c90603011719k43af0fbbg889f47d798e22839@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1141239617.23202.5.camel@rousalka.dyndns.org>
	 <4405F471.8000602@rtr.ca>
	 <1141254762.11543.10.camel@rousalka.dyndns.org>
	 <311601c90603011719k43af0fbbg889f47d798e22839@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/1/06, Eric D. Mudama <edmudama@gmail.com> wrote:
> I believe this core should not be part of the FUA whitelist.  If I
> remember correctly, there are other implementations out there with
> similar limitations to opcodes this "new" to ATA.

That being said, I see from

https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=177951

that a blacklisting of some Maxtor drives for this issue has
supposedly occurred or been pushed and accepted "upstream" in git ....
 For the obvious (selfish) reasons, I'd like to minimize the number of
Maxtor drives that are blacklisted, as I don't believe this is a drive
issue at all.

If there's a drive model out there reporting support for FUA but
screwing it up, I'm all ears as that's something I need to know about.
 If basic adapter functional testing is required for some of these
low-level commands, then that might be something I can help with too
(on a very limited scale), since we have access to ~100 different
chipsets.

--eric
