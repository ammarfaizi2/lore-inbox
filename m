Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933874AbWK0WBd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933874AbWK0WBd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 17:01:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933875AbWK0WBd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 17:01:33 -0500
Received: from wx-out-0506.google.com ([66.249.82.233]:54390 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S933874AbWK0WBc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 17:01:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=okezBmI3NKu0Uuy2RkVF3IjbQdrT7VJaK9Lj7MjSz3UbZ20v1rjC1tYsVdmj7nlzNIOqrg+8rb85ZW2nCDMv0BlJjdLAPfbLw8OjqacxAz+E+o4ivLOmzaPGka/S0zSeC4f2DMcG+OAeiD8D917GRkDJ0Bi0a7jein8vx+7WV0o=
Message-ID: <5c49b0ed0611271401g13ce1c33v1bcc35443dfe73ab@mail.gmail.com>
Date: Mon, 27 Nov 2006 14:01:31 -0800
From: "Nate Diller" <nate.diller@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "Steven Pratt" <slpratt@austin.ibm.com>,
       "Ram Pai" <linuxram@us.ibm.com>, "Neil Brown" <neilb@suse.de>,
       Voluspa <lista1@comhem.se>, "Linux Portal" <linportal@gmail.com>
Subject: Re: Adaptive readahead V16 benchmarks
In-Reply-To: <364437345.17522@ustc.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <364437345.17522@ustc.edu.cn>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/24/06, Fengguang Wu <fengguang.wu@gmail.com> wrote:
> Andrew,
>
> Here are some benchmarks for the latest adaptive readahead patchset.
>
> Most benchmarks have 3+ runs and have the numbers averaged.
> However some testing times are short and not quite stable.
>
> Most of them are carried out on my PC:
>         Seagate ST3250820A 250G/8M IDE disk, 512M Memory, AMD Sempron 2200+
>
> Basic conclusions:
> - equivalent performance in normal cases
> - much better in: busy NFS server; sparse/backward reading
> - adapts to memory size very well on randomly loading a file

These results look really good, and the code seems to be at least as
well-structured as the previous code.  I think this argues for
inclusion.

NATE
