Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290587AbSBKWpt>; Mon, 11 Feb 2002 17:45:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290586AbSBKWpj>; Mon, 11 Feb 2002 17:45:39 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:27885 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S290587AbSBKWpZ>;
	Mon, 11 Feb 2002 17:45:25 -0500
Date: Mon, 11 Feb 2002 17:43:47 -0500
From: Hubertus Franke <frankeh@watson.ibm.com>
To: Daniel Egger <degger@fhm.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: GCOV Support for Linux (including dynamic modules)
Message-ID: <20020211174347.B1931@elinux01.watson.ibm.com>
In-Reply-To: <20020211131253.A1468@elinux01.watson.ibm.com> <1013460543.1918.10.camel@sonja>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1013460543.1918.10.camel@sonja>; from degger@fhm.edu on Mon, Feb 11, 2002 at 09:49:03PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2002 at 09:49:03PM +0100, Daniel Egger wrote:
> Am Mon, 2002-02-11 um 19.12 schrieb Hubertus Franke:
> 
> > GCOV kernel support for Linux
> > =============================
> 
> I'm VERY excited about that because gcov is a very useful tool when
> used with care.
> 
> Can you already tell how much it will slow down a kernel that's compiled
> with it?

We have really not done that kind of test.
Maybe somebody wants to try it :-) and post some data back.
All we know the system runs properly if the entire kernel is gcov'd.
 
Next revision we are thinking of making this scalable through
CPU specific counter blocks (that's going to be some fun poking in gcc etc)
and see whether we can get the atomicity problem cracked.
 
>
> --
> Servus,
>        Daniel
 
(auch) Servus
-- Hubertus
