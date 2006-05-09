Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751202AbWEIWB1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbWEIWB1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 18:01:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbWEIWB1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 18:01:27 -0400
Received: from wr-out-0506.google.com ([64.233.184.230]:38850 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751202AbWEIWB0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 18:01:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BWGbhBNfR51yqjPMIOORU7WZzAhegy+bcyyOAZSveOaW6dWgFkyW/QHDwuydCHJvPkktW1LJyFjeob3WKrvX2/TSqfTO/oCZF5iZr4P88ceShabBPvf2RubDhTi2u/iaIJbGjfN+kTwTkkExqBWeScOhUTh1votJwxLxc/npKmU=
Message-ID: <9a8748490605091501r4bcff8b0q630cbf2fa0e33732@mail.gmail.com>
Date: Wed, 10 May 2006 00:01:25 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Joshua Hudson" <joshudson@gmail.com>
Subject: Re: Stability of 2.6.17-rc3?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <bda6d13a0605091340x2e16342v15733b2c9612d985@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <bda6d13a0605091340x2e16342v15733b2c9612d985@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/9/06, Joshua Hudson <joshudson@gmail.com> wrote:
> Was hoping 2.6.17 would be out within one week, doesn't look like it
> is going to happen.

It'll be released when it is ready, not according to a fixed
schedule... and yes, within one week looks unlikely.

> My thesis defense is coming up, need to merge my patches against some kernel
> (requiring 2.6.16.1 looks weird).
>
> On a machine that 2.6.16.1 runs bug-free, is it sane to assume
> 2.6.17-rc3 will as well?

I'd say no.

2.6.17-rc3 is a development kernel, no guarantees about anything really.

If you want a newer kernel stable kernel, then your safest bet would
be the latest -stable one, currently that would be 2.6.16.15

> If it fails outright, I can revert, but if it is unstable I'm going to
> have some problems.

Development kernels are run completely at your own risk. It may run
fine, it may explode at boot, it may cause slow silent corruption, it
may eat your lunch, it may cause an alien invasion - all bets are
off... (although it actually seems to be getting pretty good, I've
been running 2.6.17-rc3-git12 without problems for a while).

> (You would be surprised how long it took me to discover a mistake that
> sys_rename(on any filesystem) -> deadlock with my custom patch).


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
