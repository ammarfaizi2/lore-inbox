Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263779AbTCVRXZ>; Sat, 22 Mar 2003 12:23:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263784AbTCVRXZ>; Sat, 22 Mar 2003 12:23:25 -0500
Received: from air-2.osdl.org ([65.172.181.6]:33176 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S263779AbTCVRXY>;
	Sat, 22 Mar 2003 12:23:24 -0500
Message-ID: <33548.4.64.238.61.1048354467.squirrel@www.osdl.org>
Date: Sat, 22 Mar 2003 09:34:27 -0800 (PST)
Subject: Re: PATCH: fix proc handling in sis, siimageand slc90e66
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: <hch@infradead.org>
In-Reply-To: <20030322141522.A26332@infradead.org>
References: <200303211936.h2LJaCK7025824@hraefn.swansea.linux.org.uk>
        <20030322074911.A24305@infradead.org>
        <1048345386.8911.13.camel@irongate.swansea.linux.org.uk>
        <20030322141522.A26332@infradead.org>
X-Priority: 3
Importance: Normal
Cc: <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>,
       <torvalds@transmeta.com>
X-Mailer: SquirrelMail (version 1.2.8)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sat, Mar 22, 2003 at 03:03:06PM +0000, Alan Cox wrote:
>> On Sat, 2003-03-22 at 07:49, Christoph Hellwig wrote:
>> > > +
>> > > +	return len > count ? count : len;
>> >
>> > Shouldn't this just move to the seq_file interface?  (probably the
>> "simple" variant)
>>
>> That means making the 2.4 and 2.5 drives diverge which is a pain I don't
>> want  before 2.6
>
> The seq_file interface is already and a backport of the single stuff is
> trivial and should happen anyway.

I agree.  I helped someone do that for /proc/mdstat[s?] in 2.4
about 2 weeks ago.  Very simple to do.

~Randy



