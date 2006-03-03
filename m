Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751547AbWCCG1a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751547AbWCCG1a (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 01:27:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751997AbWCCG1a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 01:27:30 -0500
Received: from wproxy.gmail.com ([64.233.184.199]:4806 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751547AbWCCG13 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 01:27:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bQyDq6SwV3LMzaca6gyz2HPM/CKqiur2DlRwUojtxwQujpo8dskux7fMi9NnVvO7LxPbFS2CDN+8BR9lpCpYEkhh7dy6VXw2dcMCZe220MPvvR5226RLY2xCcjinhsV9goVKalmlkA3MacM8Omli2+gMTxJw88TI494UAvIMZtw=
Message-ID: <105c793f0603022227m3523a8f1vf1371d3eebe1553e@mail.gmail.com>
Date: Fri, 3 Mar 2006 01:27:28 -0500
From: "Andrew Haninger" <ahaning@gmail.com>
To: "tim tim" <tictactoe.tim@gmail.com>
Subject: Re: modutils
Cc: "Linux kernel mailing list" <linux-kernel@vger.kernel.org>
In-Reply-To: <503e0f9d0603022215h7632d8d9w7c278cd70b02d662@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <503e0f9d0603022041q717ae7cdo8539ba8f508dd681@mail.gmail.com>
	 <105c793f0603022138u6dca326ewa3b5d476f4c4ef48@mail.gmail.com>
	 <503e0f9d0603022141l5dc9a88ds380dd9dd2ba22c41@mail.gmail.com>
	 <105c793f0603022145t55f25cedpd6c40efd703530f5@mail.gmail.com>
	 <503e0f9d0603022155j2570314jffcdf84060e336f2@mail.gmail.com>
	 <105c793f0603022205j124a9d19qab33c34e9750d5c9@mail.gmail.com>
	 <503e0f9d0603022215h7632d8d9w7c278cd70b02d662@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim: Hope you don't mind me Cc'ing the list. I'd rather keep our
discussion there.

On 3/3/06, tim tim <tictactoe.tim@gmail.com> wrote:
> > I'm not sure what you mean. At least one system will need a compiler
> then..  exactly when i am telling fully installed system.. in the
> sense fully installed os .. ie there is an oprion of everything in
> RedHat.. hope u saw thar or at least i my selfs selecting all the
> packages they are showing....
I'm having trouble making sense of this sentence. You will not need to
install EVERYTHING from Redhat just to compile a kernel, you will at
least need the developer's tools. If you install those tools on one
system, you can configure and build a kernel there for another system
and then move the built kernel and it's associated modules to another
system that is not "fully installed".

> after installing modutils i can't understand what this is used for..
> even i went through tldp man pages.. they just covered a little.. but
> surely nor for a novice kernel installer...
modutils is used for handling kernel modules (drivers that can be
installed and removed fomr a running kernel) in the Linux kernel
version 2.4. The Linux kernel version 2.6 uses module-init-tools.

-Andy
