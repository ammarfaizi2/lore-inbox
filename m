Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129915AbRCDApn>; Sat, 3 Mar 2001 19:45:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129932AbRCDApc>; Sat, 3 Mar 2001 19:45:32 -0500
Received: from runyon.cygnus.com ([205.180.230.5]:26620 "EHLO cygnus.com")
	by vger.kernel.org with ESMTP id <S129915AbRCDAp2>;
	Sat, 3 Mar 2001 19:45:28 -0500
To: buhr@stat.wisc.edu (Kevin Buhr)
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: RFC: changing precision control setting in initial FPU context
In-Reply-To: <E14ZLat-0004Js-00@the-village.bc.nu>
	<vban1b2ped5.fsf@mozart.stat.wisc.edu>
Reply-To: drepper@cygnus.com (Ulrich Drepper)
X-fingerprint: BE 3B 21 04 BC 77 AC F0  61 92 E4 CB AC DD B9 5A
X-fingerprint: e6:49:07:36:9a:0d:b7:ba:b5:e9:06:f3:e7:e7:08:4a
From: Ulrich Drepper <drepper@redhat.com>
Date: 03 Mar 2001 16:45:44 -0800
In-Reply-To: buhr@stat.wisc.edu's message of "03 Mar 2001 18:27:50 -0600"
Message-ID: <m3d7byjr9j.fsf@otr.mynet.cygnus.com>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

buhr@stat.wisc.edu (Kevin Buhr) writes:

> > You want peoples existing applications to suddenely and magically change
> > their results. Umm problem.
> 
> So, how would you feel about a mechanism whereby the kernel could be
> passed a default FPU control word by the binary (with old binaries, by
> default,

There will be no change whatsoever with me.  The existing ABI is
fixed.  If you want your programs to behave different set the mode
appropriately.  I have not the slightest interest in seeing
applications (including the libc) being broken just because of this
stupid idea.  No kernel and no libc modifications necessary.  This is
the end of the story as far as I'm concerned.

-- 
---------------.                          ,-.   1325 Chesapeake Terrace
Ulrich Drepper  \    ,-------------------'   \  Sunnyvale, CA 94089 USA
Red Hat          `--' drepper at redhat.com   `------------------------
