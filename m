Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263796AbTDXRVK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 13:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263798AbTDXRVK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 13:21:10 -0400
Received: from users.eiwaz.com ([216.243.209.216]:62150 "EHLO users.eiwaz.com")
	by vger.kernel.org with ESMTP id S263796AbTDXRVF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 13:21:05 -0400
Subject: Re: Flame Linus to a crisp!
From: Andreas Boman <aboman@eiwaz.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andre Hedrick <andre@linux-ide.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0304232204480.19326-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0304232204480.19326-100000@home.transmeta.com>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1051205575.29446.98.camel@asgaard.midgaard.us>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.2 (Preview Release)
Date: 24 Apr 2003 13:32:55 -0400
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-04-24 at 01:16, Linus Torvalds wrote:
> On Wed, 23 Apr 2003, Andre Hedrick wrote:
> > 
> > Now the digital signing issue as a means to protect possible embedded or
> > distribution environments is needed.  DRM cuts two ways and do not forget
> > it!
> 
> This is _the_ most important part to remember.
> 
> Security is a two-edged sword. It can be used _for_ you, and it can be
> used _against_ you. A fence keeps the bad guys out, but by implication the
> bad guys can use it to keep _you_ out, too.
> 
> The technology itself is pretty neutral, and I'm personally pretty
> optimistic that _especially_ in an open-source environment we will find
> that most of the actual effort is going to be going into making security
> be a _pro_consumer_ thing. Security for the user, not to screw the user.
> 
Ofcourse the efforts by the OSS community will focus on security for the
user, and better security is something we all want. No arguments there.

> Put another way: I'd rather embrace it for the positive things it can do
> for us, than have _others_ embrace it for the things it can do for them.

I agree that the licence does/should not disallow signing. However I
don't see how that is tied to "the current DRM initiative" though
(perhaps im just clueless, I have no doubt that you know more of the
details of DRM than I do). We can do this today. There are patches out
there that let the kernel refuse to run unsigned userspace code.
Hardware dongles have been in existence for eons. 

It seems to me that embracing DRM will in the near future allow linux
distro vendors to ship signed binaries, to allow their users to use any
online services that will require a DRM operating system. Perhaps that
is the positive things you refer to.

Further in the future it will allow linux to exist as a current OS,
after we get DRM enabled hardware that refuse to boot unsigned kernels.
Larger linux vendors can afford to have their kernels (and userspace)
signed by $signing_entity. Perhaps they will be able to purchase some
'licence to sign' on their own from hardware vendors, and not have to
wait a few months to get that latest kernel with the 2 liner buffer
overflow patch released. 

> > For those not aware, each and every kernel you download from K.O is DRM
> > signed as a means to authenticate purity.
> 
> Yup. And pretty much every official .rpm or .deb package (source and
> binary) is already signed by the company that made that package, for
> _your_ protection. This is already "accepted practice", so allowing 
> signing is not something new per se, including on a binary level.

Sure, but today a signed kernel from $vendor doesnt prevent me from
running a program I compiled myself, the signature only shows me that
the kernel infact came from $vendor and if I trust that vendor, I can
now trust that kernel. 

> So what I hope this discussion brings as news is to make people aware of
> it. And that very much includes making people aware of the fact that there
> are some scary sides to signing stuff 

I don't feel signing stuff has any scary sides. The scary part is that 
*my* signature will be worthless, and I'm scared that in 10 years I wont
be able to boot my own kernels, or run my own userspace code. 

In the near future I'm worried about the fact that I could become second
class netizen if I dont run a signed $large_linux_vendor kernel and
userspace chain all the way up to a signed mozilla. I quite like paying
my bills on-line.

Ofcourse thoose things would most likely happen weather linux embraced
DRM or not, exept that if linux did not allow signing we would all be
forced to use another operating system, exept on that one still working
old slow quad xeon box that really doesnt do much, it cant even connect
to the internet since its packets arent signed, but its a fun toy to
play with and think about the good 'ol days when we could boot linux.

> - and that they're par for the
> course, and part of the package. I know for a fact that a number of 
> people were hoping for the upsides without any of the downsides. That's 
> not how it works.

I believe the proverb goes: "Du kan inte äta kakan och ha den kvar."
(You can't eat the cookie and still have it left). 

	Andreas


