Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292266AbSBTTyb>; Wed, 20 Feb 2002 14:54:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292255AbSBTTyV>; Wed, 20 Feb 2002 14:54:21 -0500
Received: from zero.tech9.net ([209.61.188.187]:2052 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S292254AbSBTTyM>;
	Wed, 20 Feb 2002 14:54:12 -0500
Subject: Re: jiffies rollover, uptime etc.
From: Robert Love <rml@tech9.net>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Mike Fedyk <mfedyk@matchmail.com>, Ville Herva <vherva@twilight.cs.hut.fi>,
        george anzinger <george@mvista.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44L.0202201423170.1413-100000@duckman.distro.conectiva>
In-Reply-To: <Pine.LNX.4.44L.0202201423170.1413-100000@duckman.distro.conectiva>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 20 Feb 2002 14:53:43 -0500
Message-Id: <1014234823.18361.50.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-02-20 at 12:24, Rik van Riel wrote:

> One is a 64 bit extension to a modern superscalar
> architecture which has descended from 8 bit machines
> over the ages.
> 
> The other is a 3-issue VLIW follow-up to the 2-issue
> VLIW i860.

One nitpick ;-)

The IA-64 architecture does not limit the number of parallel
instructions.  I believe IPF (current Itanium) has a limit of 2 bundles
per instruction group, and with 3 instructions per bundle, that gives a
max of 6 parallel instructions.  This can change in the future, though.

I learned this in (no, he isn't paying me!) David's IA-64 Kernel book.

	Robert Love

