Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265472AbTFVDa2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 23:30:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265473AbTFVDa2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 23:30:28 -0400
Received: from franka.aracnet.com ([216.99.193.44]:36021 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S265472AbTFVDa1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 23:30:27 -0400
Date: Sat, 21 Jun 2003 20:43:52 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>,
       Arnaldo Carvalho de Melo <acme@conectiva.com.br>
cc: cw@f00f.org, torvalds@transmeta.com, geert@linux-m68k.org,
       alan@lxorguk.ukuu.org.uk, perex@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Isapnp warning
Message-ID: <90770000.1056253431@[10.10.2.4]>
In-Reply-To: <20030621191705.3c1dbb16.akpm@digeo.com>
References: <20030621125111.0bb3dc1c.akpm@digeo.com><Pine.LNX.4.44.0306211652130.1980-100000@home.transmeta.com><20030622001101.GB10801@conectiva.com.br><20030622014102.GB29661@dingdong.cryptoapps.com><20030622014345.GD10801@conectiva.com.br> <20030621191705.3c1dbb16.akpm@digeo.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Andrew Morton <akpm@digeo.com> wrote (on Saturday, June 21, 2003 19:17:05 -0700):

> Arnaldo Carvalho de Melo <acme@conectiva.com.br> wrote:
>> 
>> Em Sat, Jun 21, 2003 at 08:41:02PM -0500, Chris Wedgwood escreveu:
>> > On Sat, Jun 21, 2003 at 09:11:01PM -0300, Arnaldo Carvalho de Melo wrote:
>> > 
>> > > Humm, I'd love to do that, i.e. to make gcc 3 required, lots of good
>> > > stuff like this one, anonymous structs, etc, etc, lots of stuff
>> > > could be done in an easier way, but are we ready to abandon gcc
>> > > 2.95.*? Can anyone confirm if gcc 2.96 accepts this?
>> > 
>> > What *requires* 2.96 still?  Is it a large number of people or obscure
>> > architecture?
>> 
>> I don't know, I was just trying to figure out the impact of requiring gcc 3
>> to compile the kernel. I never used gcc 2.96 btw.
>> 
> 
> Compared to 2.95.3, gcc-3.3 takes 1.5x as long to compile, and produces a
> kernel which is 200k larger.
> 
> It is simply worthless.

Agreed. 2.95.4 is also still the default debian compiler. Requiring
3.x seems like a bad plan, until they get it to a point where it's
actually better than 2.95, stable, and widely distributed. It's 
definitely not there yet (seems kind of stable, but not the others).

M.

