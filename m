Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316519AbSHOD0W>; Wed, 14 Aug 2002 23:26:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316535AbSHOD0W>; Wed, 14 Aug 2002 23:26:22 -0400
Received: from otter.mbay.net ([206.55.237.2]:4623 "EHLO otter.mbay.net")
	by vger.kernel.org with ESMTP id <S316519AbSHOD0V> convert rfc822-to-8bit;
	Wed, 14 Aug 2002 23:26:21 -0400
From: John Alvord <jalvo@mbay.net>
To: Greg Banks <gnb@alphalink.com.au>
Cc: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] Re: [patch] config language dep_* enhancements
Date: Wed, 14 Aug 2002 20:30:09 -0700
Message-ID: <as7mlucq38obgsecg8kbh3vqjqiiic35bl@4ax.com>
References: <Pine.LNX.4.44.0208141242280.8911-100000@serv> <3D5B0970.13CE831A@alphalink.com.au>
In-Reply-To: <3D5B0970.13CE831A@alphalink.com.au>
X-Mailer: Forte Agent 1.92/32.570
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Aug 2002 11:52:48 +1000, Greg Banks <gnb@alphalink.com.au>
wrote:

>Roman Zippel wrote:
>> 
>> Hi,
>> 
>> On Tue, 13 Aug 2002, Peter Samuelson wrote:
>> 
>> > Mutating the language, long-term, so that it looks less like sh [...]
>> 
>> That doesn't solve any of the more fundamental problems.
>
>Correct, it doesn't.
>
>> 1) We still have 3 config parsers, which produce slightly different
>> .config files.
>
>Yes.
>
>> 2) To integrate a new driver, you have to touch at least 3 files:
>> Config.in, Config.help, Makefile. Properly configuring and building a
>> driver outside of the tree is painful to impossible.
>
>Yes.
>
>> The problems are really not simple, the current config language is very
>> limited, [...]
>
>I don't think anyone who actually understands the config system would
>argue these points, but we are limited by practical constraints to making
>incremental improvements only.

I've been puzzling about this problem and the CML2 trainwreck.

Maybe we can used advanced tools to remove the many bugs and
inconsistancies and then switch to a better config tool. That way the
rulebase will be (almost) identical when the config process changes.

john alvord
