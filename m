Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264989AbUEYRd7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264989AbUEYRd7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 13:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264990AbUEYRd7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 13:33:59 -0400
Received: from fw.osdl.org ([65.172.181.6]:11436 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264989AbUEYRd5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 13:33:57 -0400
Date: Tue, 25 May 2004 10:33:55 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "pvant67@wnyip.net" <pvant67@wnyip.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Kernel origins and maintainers
In-Reply-To: <40B384DE.9060504@wnyip.net>
Message-ID: <Pine.LNX.4.58.0405251028170.9951@ppc970.osdl.org>
References: <40B384DE.9060504@wnyip.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 25 May 2004, pvant67@wnyip.net wrote:
>
> I'm busy putting together a list of all the contributors and maintainers 
> that I can find, using the CREDITS and MAINTAINERS files. I have not 
> seen this done in one place before; is it redundant effort?

I don't think I've seen it before.

For the last two years, you can find a lot of email addresses in BK, and 
you can clean them up with the name translations found in the "shortlog" 
script (part of "BK-tools" at http://bktools.bkbits.net/bktools).

> How does this overlap with the new Developer's Certificate of Origin? I 
> have the distinct impression that these projects should be working 
> closer together.

Well, right now you won't get any real information from the sign-off
lines, since only a few people have started using it (7 people at the time
of this writing ;), so you're better off just doing statistics on the 
output of "bk changes -a" or something.

		Linus
