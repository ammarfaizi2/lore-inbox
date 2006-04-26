Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750982AbWDZXG1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750982AbWDZXG1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 19:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751008AbWDZXG1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 19:06:27 -0400
Received: from uproxy.gmail.com ([66.249.92.168]:6083 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750959AbWDZXGZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 19:06:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=d/CR7WbQEkJOqjosiTBMxlwIC5F1kCxzzNiTElNX1ErZ1pwad4IDkTARYo5JLZYWqUqBiL/pDczkYYd6s66Cxsq3Pd/VQBb/4NAppOxL+7mR6WfWC8l3KRX5Mf1IoksXhyDGriwtQGsuVaKpVEL2frmW4oJ5ct72ZtOYMSGdEM4=
Message-ID: <ef88c0e00604261606g64ed5844j67890e8c3d7974a9@mail.gmail.com>
Date: Wed, 26 Apr 2006 16:06:24 -0700
From: "Ken Brush" <kbrush@gmail.com>
To: "Neil Brown" <neilb@suse.de>
Subject: Re: Some Concrete AppArmor Questions - was Re: [RFC][PATCH 0/11] security: AppArmor - Overview
Cc: "Stephen Smalley" <sds@tycho.nsa.gov>,
       "Chris Wright" <chrisw@sous-sol.org>,
       "James Morris" <jmorris@namei.org>,
       "Arjan van de Ven" <arjan@infradead.org>, "Andi Kleen" <ak@suse.de>,
       linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
In-Reply-To: <17487.61698.879132.891619@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com>
	 <20060420192717.GA3828@sorel.sous-sol.org>
	 <1145621926.21749.29.camel@moss-spartans.epoch.ncsc.mil>
	 <20060421173008.GB3061@sorel.sous-sol.org>
	 <1145642853.21749.232.camel@moss-spartans.epoch.ncsc.mil>
	 <17484.20906.122444.964025@cse.unsw.edu.au>
	 <1145911526.14804.71.camel@moss-spartans.epoch.ncsc.mil>
	 <17485.55676.177514.848509@cse.unsw.edu.au>
	 <1145984831.21399.74.camel@moss-spartans.epoch.ncsc.mil>
	 <17487.61698.879132.891619@cse.unsw.edu.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/26/06, Neil Brown <neilb@suse.de> wrote:
>
> I feel we have reached the stage where the questions/comments being
> made are actually directly relevant to AppArmor.  I'm afraid I cannot
> proceed any further now because I am not a security expert.
>
> I would like to summarise what I think are the key points that you
> have raised, and hope that someone who has a deeper understanding of
> these things might answer them, or point to answers.
>
> 1/ Does AppArmor's primary mechanism of confining an application to a
>   superset of it's expected behaviour actually achieve its secondary
>   gaol of protecting data?
>
>   Possibly it would be better to ask "When does ..."  as I think it is
>   easy to imagine application/profile pairs that clearly cannot allow
>   harm, and application/profile pairs that clearly could allow harm.

Depends on the data. A properly constrained Apache webserver would be
prevented from accessing data it shouldn't.

> 2/ What advantages does AppArmor provide over techniques involving
>    virtualisation or gaol mechanisms?  Are these advantages worth
>    while?

If you just wish to run every application in a chrooted jail. Would
you still need a MAC solution?

> 3/ Is AppArmour's approach of using d_path to get a filename from a
>    dentry valid and acceptable?  If not, how can it get a path?  Can
>    suitable hooks be provided so that AppArmor can get a path in an
>    acceptable way at the times when that is meaningful?

I'll leave this for the others...

> I believe that these are all good questions.  The last one is the only
> one that it really relevant to linux-kernel I believe, however answers
> to the first two might tell us how important it is to answer that last
> one.
>
> Thanks for your input.
>
> NeilBrown
>
[snipped]

-Ken
