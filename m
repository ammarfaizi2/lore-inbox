Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030703AbWAKA5X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030703AbWAKA5X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 19:57:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932554AbWAKA5X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 19:57:23 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:29196 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932553AbWAKA5W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 19:57:22 -0500
Date: Wed, 11 Jan 2006 01:57:21 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Ian McDonald <imcdnzl@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       trivial@kernel.org, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: Revised [PATCH] Documentation: Update to SubmittingPatches
Message-ID: <20060111005721.GA29663@stusta.de>
References: <cbec11ac0512201343q79de6e13h6fccf1259445076@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbec11ac0512201343q79de6e13h6fccf1259445076@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2005 at 10:43:40AM +1300, Ian McDonald wrote:
> Updated documentation for submitting patches taking account of git.
> 
> Signed-off-by: Ian McDonald <imcdnzl@gmail.com>
> ---
> diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
> index 237d54c..8756475 100644
> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -20,10 +20,24 @@ SECTION 1 - CREATING AND SENDING YOUR CH
> 
> 
> 
> -1) "diff -up"
> -------------
> +1) Creating a diff file
> +-----------------------
> 
> -Use "diff -up" or "diff -uprN" to create patches.
> +You can use git-diff(1) or git-format-patch(1) which makes your life easy. If
> +you want it to be more difficult then carry on reading.
>...

IMHO, this doesn't make much sense:

The average patch submitter does _not_ use git in any way - and there's 
no reason why he should.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

