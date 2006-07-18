Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932081AbWGRIDj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbWGRIDj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 04:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932083AbWGRIDj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 04:03:39 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:34235 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S932081AbWGRIDi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 04:03:38 -0400
Date: Tue, 18 Jul 2006 09:59:21 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Matthias Andree <matthias.andree@gmx.de>
cc: Grzegorz Kulewski <kangur@polcom.net>, Diego Calleja <diegocg@gmail.com>,
       arjan@infradead.org, caleb@calebgray.com, linux-kernel@vger.kernel.org
Subject: Re: Reiser4 Inclusion
In-Reply-To: <20060717155151.GD8276@merlin.emma.line.org>
Message-ID: <Pine.LNX.4.61.0607180951480.16615@yvahk01.tjqt.qr>
References: <44BAFDB7.9050203@calebgray.com> <1153128374.3062.10.camel@laptopd505.fenrus.org>
 <Pine.LNX.4.63.0607171242350.10427@alpha.polcom.net>
 <20060717160618.013ea282.diegocg@gmail.com> <Pine.LNX.4.63.0607171611080.10427@alpha.polcom.net>
 <20060717155151.GD8276@merlin.emma.line.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>Any why can those users not download and apply a patch, try it and
>report back to Namesys?
>
Because that patch pokes into some files outside fs/reiser4, giving a hard time
with rejects for the novice user. The linux kernel is a huge codebase, and 
I have, for example, less clue of mm/ than of fs/.

I was very happy to see that
ftp://ftp.namesys.com/pub/reiser4-for-2.6/2.6.16/reiser4-for-2.6.16-4.patch.gz
worked well on 2.6.17 and 2.6.17.x, but it already stopped patching again 
on 2.6.18-rc1. The next newer version of reiser4 is for -mm, which is not 
so useful for me. If namesys provided reiser4 patches for every vanilla out 
there (possibly including -rc's, but that's just extra sugar), that would 
be great, but I cannot force them to do so; people may have better things 
to do than packaging up r4 whenever there is a linux tarball release.



Jan Engelhardt
-- 
