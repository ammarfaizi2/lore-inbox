Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291288AbSAaUpC>; Thu, 31 Jan 2002 15:45:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291287AbSAaUov>; Thu, 31 Jan 2002 15:44:51 -0500
Received: from mailgate.rz.uni-karlsruhe.de ([129.13.64.97]:52752 "EHLO
	mailgate.rz.uni-karlsruhe.de") by vger.kernel.org with ESMTP
	id <S291285AbSAaUog>; Thu, 31 Jan 2002 15:44:36 -0500
Date: Thu, 31 Jan 2002 21:44:32 +0100 (CET)
From: Martin Bahlinger <ry42@rz.uni-karlsruhe.de>
X-X-Sender: <ry42@hek411.hek.uni-karlsruhe.de>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Current Reiserfs Update / 2.5.2-dj7 Oops
In-Reply-To: <1012499057.704.0.camel@hek411>
Message-ID: <Pine.LNX.4.31.0201312133490.652-100000@hek411.hek.uni-karlsruhe.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 31 Jan 2002, Martin Bahlinger wrote:
> After applying those patches to 2.5.3 I still got an Oops after a
> PAP-14030 message. I will try to catch the Oops (have never done this
> before, may take some time) and feed it to ksymoops.

I actually had PAP-5760. And after applying the patches it was the
PAP-14030. During all the tests today my reiserfs got currupted. A
reiserfsck ran into a segfault when checking the semantic tree. And this
happened exactly while checking /var/log/ksymoops/20020131.log ;-) After
deleting this file reiserfsck did it's job and my 2.5.3 works now.

bye and thanks for the fix,
  Martin

-- 
Martin Bahlinger <bahlinger@rz.uni-karlsruhe.de>   (PGP-ID: 0x98C32AC5)



