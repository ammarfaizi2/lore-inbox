Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261825AbUAIOqe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 09:46:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261827AbUAIOqe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 09:46:34 -0500
Received: from [193.138.115.2] ([193.138.115.2]:22290 "HELO
	diftmgw.backbone.dif.dk") by vger.kernel.org with SMTP
	id S261825AbUAIOqc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 09:46:32 -0500
Date: Fri, 9 Jan 2004 15:43:43 +0100 (CET)
From: Jesper Juhl <juhl@dif.dk>
To: "Yury V. Umanets" <umka@namesys.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: eliminating gcc warning...
In-Reply-To: <1073652555.17813.9.camel@firefly>
Message-ID: <Pine.LNX.4.56.0401091539140.12106@jju_lnx.backbone.dif.dk>
References: <1073652555.17813.9.camel@firefly>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 9 Jan 2004, Yury V. Umanets wrote:

> Hello all,
>
> I'm trying to eliminate all gcc warnings, which can be obtained by means
> of using -Wall and -W gcc keys, in linux-2.6.1. I decided, that this
> should be done step-by-step. And now I have made a patch for scripts
> directory. See attachment.
>
> If something wrong and someone is so kind to tell me about, I will be
> very thankful.
>

I'm doing a similar thing, and there's been quite a lot of discussion
about patches of this sort.

You should read the threads with these titles that have been active for
the last few days :

"Suspected bug infilesystems (UFS,ADFS,BEFS,BFS,ReiserFS) related to sector_t being unsigned, advice requested"
"[PATCH] mm/slab.c remove impossible <0 check - size_t is not signed - patch is against 2.6.1-rc1-mm2"
"[PATCH] fs/fcntl.c - remove impossible <0 check in do_fcntl - arg is unsigned."
"[PATCH][RFC] variable size and signedness issues in ldt.c - potential problem?"
"Cleanup patches - comparison is always [true|false] + unsigned/signed compare, and similar issues"

A lot of good comments have been made by various people in those threads
about what type of patches are wanted and what type of patches are not
wanted. Also some comments on what kind of warnings not to bother with
(and why) have been made.

May I suggest that we maybe work together on this instead of duplicating
eachothers effort?
If you think that cooperating on this is a good idea, then feel free to
email me privately and let's talk about how to split the task between us.


-- Jesper Juhl

