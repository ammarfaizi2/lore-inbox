Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266768AbUJTGHf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266768AbUJTGHf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 02:07:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266034AbUJTGEn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 02:04:43 -0400
Received: from [64.167.48.9] ([64.167.48.9]:45074 "EHLO
	mail.bigsurwireless.com") by vger.kernel.org with ESMTP
	id S266768AbUJTF6g convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 01:58:36 -0400
From: John Alvord <jalvo@mbay.net>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Ryan Anderson <ryan@michonline.com>, "Jeff V. Merkey" <jmerkey@drdos.com>,
       Dax Kelson <dax@gurulabs.com>, Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.9 and GPL Buyout
Date: Tue, 19 Oct 2004 22:58:26 -0700
Message-ID: <advbn0p54c38l4i574hn95969oje9tkuvu@4ax.com>
References: <Pine.LNX.4.58.0410181540080.2287@ppc970.osdl.org> <417550FB.8020404@drdos.com> <1098218286.8675.82.camel@mentorng.gurulabs.com> <41757478.4090402@drdos.com>  <20041020034524.GD10638@michonline.com> <1098245904.23628.84.camel@krustophenia.net>
In-Reply-To: <1098245904.23628.84.camel@krustophenia.net>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Oct 2004 00:18:25 -0400, Lee Revell <rlrevell@joe-job.com>
wrote:

>On Tue, 2004-10-19 at 23:45, Ryan Anderson wrote:
>> RCU - originally a paper, implemented in Dynix and in other operating
>> systems from the paper (and patent), implemented in Linux as well.
>
>You could also make a strong argument that that patent is invalid
>because RCU is obvious.  I was doing this with perl and SQL before I
>ever heard of RCU.  If you don't want to lock a table (or didn't realize
>SQL had such a thing as table locking :-) you just fetch a value, make
>some calculation on it, then do the update iff that value has not
>changed.  If it has changed you fetch the new value and go back to step
>1.  It's just the obvious way to update a shared data structure if you
>have cmpxchg but no locking.

1972, IBM S/370 instruction set, CS Compare and Swap (32 bits) and CDS
Compare Double and Swap (64 bits), atomic compare and replace if test
equal. The Principles of Operation book even had sample code...

john alvord
