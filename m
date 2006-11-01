Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423875AbWKAA66@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423875AbWKAA66 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 19:58:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423877AbWKAA66
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 19:58:58 -0500
Received: from mail.parknet.jp ([210.171.160.80]:59912 "EHLO parknet.jp")
	by vger.kernel.org with ESMTP id S1423741AbWKAA65 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 19:58:57 -0500
X-AuthUser: hirofumi@parknet.jp
To: "Holden Karau" <holden@pigscanfly.ca>
Cc: "Holden Karau" <holdenk@xandros.com>,
       "Josef Sipek" <jsipek@fsl.cs.sunysb.edu>, linux-kernel@vger.kernel.org,
       "akpm\@osdl.org" <akpm@osdl.org>, linux-fsdevel@vger.kernel.org,
       "Nick Piggin" <nickpiggin@yahoo.com.au>,
       =?iso-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
Subject: Re: [PATCH 1/1] fat: improve sync performance by grouping writes revised
References: <454765AC.1050905@xandros.com>
	<87mz7cqvd8.fsf@duaron.myhome.or.jp>
	<f46018bb0610311046t6aa969ccy60a2020f7e5a0ed9@mail.gmail.com>
	<87slh4tesh.fsf@duaron.myhome.or.jp>
	<f46018bb0610311254u30063d57gebc2e0e190398c9@mail.gmail.com>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Wed, 01 Nov 2006 09:58:48 +0900
In-Reply-To: <f46018bb0610311254u30063d57gebc2e0e190398c9@mail.gmail.com> (Holden Karau's message of "Tue\, 31 Oct 2006 15\:54\:46 -0500")
Message-ID: <87odrst22f.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Holden Karau" <holden@pigscanfly.ca> writes:

> This patch is just meant to make fat32 sync performance better, not
> necessarily make it usable for everyone [one step at a time and all
> that].

Sorry, I can't see your point. The FAT12 and FAT16 also have backup FAT.
And the your patch didn't make performance better, right?
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
