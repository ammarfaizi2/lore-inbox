Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262675AbUJ1ACy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262675AbUJ1ACy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 20:02:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262538AbUJ0SpL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 14:45:11 -0400
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:31137 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S262641AbUJ0Shj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 14:37:39 -0400
Reply-To: <hzhong@cisco.com>
From: "Hua Zhong" <hzhong@cisco.com>
To: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>
Cc: "'John Richard Moser'" <nigelenki@comcast.net>,
       =?gb2312?B?J0VzcGVuIEZqZWxsduZyIE9sc2VuJw==?= <espenfjo@gmail.com>,
       "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: RE: My thoughts on the "new development model"
Date: Wed, 27 Oct 2004 11:37:34 -0700
Organization: Cisco Systems
Message-ID: <007101c4bc54$065ba2c0$103147ab@amer.cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
Importance: Normal
In-Reply-To: <1098890996.4302.14.camel@localhost.localdomain>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4939.300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Maw, 2004-10-26 at 17:58, Hua Zhong wrote:
> > The fact is, these days nobody wants to be a stable-release 
> >maintainer anymore. It's boring.
> 
> That depends what kind of an engineer you are. Just as there 
> are people who love standards body work and compliance 
> testing/debugging there are people who care about stable trees.

Absolutely agreed. There are folks around me who can do one thing much
better than the other.

When I said "nobody", I really meant "top kernel developers". I have not
seen anyone step up and say "I'll volunteer to maintain a 2.6 stable
release" hence the comment.

This is actually not a problem caused by the new development model per se.
The same thing might have happened with 2.4. You know what I'm talking
about. Most talented people just like new challenges instead of maintaining
old code.

However, there are some things that make this situation worse by the new
model.
1. No official stable releases and thus no official maintainers. 2.6 is no
longer a stable release. 2.6.x might be. And Linus doesn't seem to plan to
endorse anyone for this job. Previously, Linus could appoint someone and
even if he is not really well-known, people would eventually accept him, but
now it's not the case anymore. More importantly, if there is no official
stable releases, whom do other people send bug fixes to? From both user and
developer perspective, this is very hard to work out.

2. The new version scheme. Now a stable release has to be 2.6.x. So instead
of being a 2.6 maintainer, you might be called a 2.6.x maintainer. One extra
number, less importance and recognicion, and less motivation for volunteers
to show up (especially for relatively new people). Just common psychology.
:)

These are just my observations. As far as I can see only two things will
help:
1. Appoint an official 2.6 maintainer. Be it someone Linus appoints, or
someone like Alan Cox who volunteers. :-)
2. This maintainer will not be stuck at only one 2.6.x version. Instead, he
maintains 2.6.x for a while until it is stable enough, and then move up to
2.6.y (y>x), and start the stabilization again.

Hua

