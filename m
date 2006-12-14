Return-Path: <linux-kernel-owner+w=401wt.eu-S1750972AbWLNTyc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750972AbWLNTyc (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 14:54:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750959AbWLNTyb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 14:54:31 -0500
Received: from rwcrmhc12.comcast.net ([204.127.192.82]:52418 "EHLO
	rwcrmhc12.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750795AbWLNTya (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 14:54:30 -0500
Message-ID: <4581A75C.9020509@wolfmountaingroup.com>
Date: Thu, 14 Dec 2006 12:34:52 -0700
From: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050921 Red Hat/1.7.12-1.4.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Scott Preece <sepreece@gmail.com>
CC: Chris Wedgwood <cw@f00f.org>, Eric Sandeen <sandeen@sandeen.net>,
       Christoph Hellwig <hch@infradead.org>,
       Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jeff@garzik.org>,
       Greg KH <gregkh@suse.de>, Jonathan Corbet <corbet@lwn.net>,
       Andrew Morton <akpm@osdl.org>, Martin Bligh <mbligh@mbligh.org>,
       "Michael K. Edwards" <medwards.linux@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: GPL only modules [was Re: [GIT PATCH] more Driver core patches
 for 2.6.19]
References: <20061214003246.GA12162@suse.de> <20061214005532.GA12790@suse.de>	 <Pine.LNX.4.64.0612131954530.5718@woody.osdl.org>	 <458171C1.3070400@garzik.org>	 <Pine.LNX.4.64.0612140855250.5718@woody.osdl.org>	 <20061214170841.GA11196@tuatara.stupidest.org>	 <20061214173827.GC3452@infradead.org>	 <20061214175253.GB12498@tuatara.stupidest.org>	 <458194B8.1090309@sandeen.net>	 <20061214183956.GA13692@tuatara.stupidest.org> <7b69d1470612141142k63cc7d11l89c0a7f26acc631a@mail.gmail.com>
In-Reply-To: <7b69d1470612141142k63cc7d11l89c0a7f26acc631a@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This whole effort is pointless.  This is the same kind of crap MICROSOFT 
DOES to create incompatibilities
DELIBERATELY.  The code is either FREE or its NOT FREE.    If the code 
is FREE then let it be.  You can put whatever
you want in the code -- I will remove any such constructs, just like I 
remove them frm Red Hat's releases when they put
in the same kind of deliberate breakage for anti-competitive reasons.

You can go and yell at Novell too, since they do the SAME THING with 
their releases and mix their modules with Linux.

All someone has to do or say is.

"... I did not ever accept the GPL license with the FREE code I was 
given.  They said the code was FREE, and I took them
at their word. .."

FREE implies a transfer of ownsership and you also have to contend with 
the Doctrine of Estoppel.  i.e. if someone
has been using the code for over two years, and you have not brought a 
cause of action, you are BARRED from doing so
under the Doctrine of Estoppel and statute of limitations. 

Here's what that means so you can look it up:

http://en.wikigadugi.org/wiki/Estoppel

What Linus argued is that FREE means just that. 

Jeff


Scott Preece wrote:

> On 12/14/06, Chris Wedgwood <cw@f00f.org> wrote:
>
>> On Thu, Dec 14, 2006 at 12:15:20PM -0600, Eric Sandeen wrote:
>>
>> > Please don't use that name, it strikes me as much more confusing
>> > than EXPORT_SYMBOL_GPL, even though I agree that _GPL doesn't quite
>> > convey what it means, either.
>>
>> Calling internal symbols _INTERNAL is confusing?
>
>
> I think it's the combination of "INTERNAL" and "EXPORT" that seems
> contradictory - "If it's internal, why are you exporting it?"
>
> I think "EXPORT_SYMBOL_GPL_ONLY" or "...ONLY UNDER_GPL" would make the
> meaning clearer, but I don't really think the gain is worth the pain.
> Anybody using kernel interfaces ought to be able to figure it out.
>
>>
>> But those symbols aren't, they're about internal interfaces that might
>> change.
>
>
> Folks who think this is likely to make a difference in court might
> want to look at
> <http:www.linuxworld.com/news/2006/120806-closed-modules2.html> for a
> litany of court cases that have rejected infringement claims where a
> much sterner effort had been made to hide or block use of interfaces.
> The article claims that courts have increasingly found that
> interfacing your code to an existing work is not infringement,
> regardless of what you have to work around to do it.
>
> Of course, that's one author's reading of the case law and I'm sure
> there are others who disagree, but it's something you'd want to keep
> in mind in calculating the expected value of a suit...
>
> scott
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

