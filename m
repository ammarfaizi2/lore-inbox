Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751292AbWADVCh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751292AbWADVCh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 16:02:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751797AbWADVBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 16:01:51 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:29708 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1751292AbWADVBp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 16:01:45 -0500
Date: Wed, 4 Jan 2006 22:01:22 +0100
From: Willy Tarreau <willy@w.ods.org>
To: David Brown <dmlb2000@gmail.com>
Cc: "YOSHIFUJI Hideaki / ?$B5HF#1QL@" <yoshfuji@linux-ipv6.org>, mingo@elte.hu,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rt1
Message-ID: <20060104210122.GA7142@w.ods.org>
References: <9c21eeae0601031512m44c4a269ua2214528eaf90914@mail.gmail.com> <20060103.202422.50699198.yoshfuji@linux-ipv6.org> <9c21eeae0601032316l3259fbecle6a0b290ed244e12@mail.gmail.com> <20060104.014301.113325512.yoshfuji@linux-ipv6.org> <9c21eeae0601032350q747e8733q7fa752aa3332a13c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c21eeae0601032350q747e8733q7fa752aa3332a13c@mail.gmail.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2006 at 11:50:52PM -0800, David Brown wrote:
> > I have linux-2.6 git tree and I did something like this:
> >
> > $ cd linux-2.6
> > $ patch -p1 < /tmp/patch-2.6.15-rt1
> > hack, hack, hack...
> > $ patch -p1 -R < /tmp/patch-2.6.15-rt1
> > $ git reset
> > $ git diff
> 
> Thanks again, this reminds me that I'm going to have to make a serious
> effort to learn how to use git.

"serious" is the appropriate word here :-)
BTW, if you want to know what has changed between the original patch
and yours, you can use interdiff from diffutils. It will give you a
patch between what the trees you would get by applying your patches.
It's very useful for such usages !

> - David Brown

Regards,
Willy

