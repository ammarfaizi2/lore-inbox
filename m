Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131739AbRBQOoF>; Sat, 17 Feb 2001 09:44:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131801AbRBQOnz>; Sat, 17 Feb 2001 09:43:55 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:24334 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S131739AbRBQOnk>; Sat, 17 Feb 2001 09:43:40 -0500
Date: Sat, 17 Feb 2001 08:43:30 -0600
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Manfred Spraul <manfred@colorfullife.com>, linux-kernel@vger.kernel.org
Subject: Re: Is this the ultimate stack-smash fix?
Message-ID: <20010217084330.A17398@cadcamlab.org>
In-Reply-To: <3A899FEB.D54ABBC7@sympatico.ca> <m1lmr98c5t.fsf@frodo.biederman.org> <3A8ADA30.2936D3B1@sympatico.ca> <m1hf1w8qea.fsf@frodo.biederman.org> <3A8BF5ED.1C12435A@colorfullife.com> <m1k86s6imn.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <m1k86s6imn.fsf@frodo.biederman.org>; from ebiederm@xmission.com on Thu, Feb 15, 2001 at 09:00:48AM -0700
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  [Manfred Spraul]
> > Unless you modify the ABI and pass the array bounds around you won't
> > catch such problems, 

[Eric W. Biederman]
> Of course.  But this is linux and you have the source.  And I did
> mention you needed to recompile the libraries your trusted
> applications depended on.

So by what ABI do you propose to pass array bounds to a called
function?  It sounds pretty ugly.  It also sounds like you will be
breaking the extremely useful C postulate that, at the ABI level at
least, arrays and pointers are equivalent.  I can't see *how* you plan
to work around that one.

> Yep bounds checking is not an easy fix.

Understatement of the year, if you really want to catch all cases.

Peter
