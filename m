Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292252AbSBBIa5>; Sat, 2 Feb 2002 03:30:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292253AbSBBIap>; Sat, 2 Feb 2002 03:30:45 -0500
Received: from linuxhacker.ru ([212.16.0.238]:19205 "EHLO linuxhacker.ru")
	by vger.kernel.org with ESMTP id <S292252AbSBBIaf>;
	Sat, 2 Feb 2002 03:30:35 -0500
Date: Sat, 2 Feb 2002 11:30:52 +0300
Message-Id: <200202020830.g128UqJ05226@linuxhacker.ru>
From: Oleg Drokin <green@linuxhacker.ru>
Subject: Re: Current Reiserfs Update / 2.5.2-dj7 Oops
To: linux-kernel@vger.kernel.org, ry42@rz.uni-karlsruhe.de
In-Reply-To: <1012499057.704.0.camel@hek411> <Pine.LNX.4.31.0201312133490.652-100000@hek411.hek.uni-karlsruhe.de>  <20020201085545.A1034@namesys.com> <1012601878.644.0.camel@hek411>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Bahlinger <ry42@rz.uni-karlsruhe.de> wrote:

MB> Because I don't have my first build of 2.5.3 any more, I had to compile
MB> a new one without any patches applied to it. But now I get a completely
MB> different behaviour: I can boot without problems and get those PAP-5580
MB> oops after a few minutes uptime. I attached the oops message and the
MB> output of ksymoops at the end of this mail.
Ok, thank you. Though this one is already fixed.

MB> I think, the other oops (PAP-14030) happened because of those filesystem
MB> corruptions I mentioned before. Maybe the fs corrupted during the first
Sad, you cannot reproduce it anymore.

>> > reiserfsck ran into a segfault when checking the semantic tree. And this
>> This means you need updated reiserfsprogs.
MB> I use reiserfsprogs 3.x.0j as recommended by linux/Documentation/Changes
We will eventually change that to something more recent.

Bye,
    Oleg
