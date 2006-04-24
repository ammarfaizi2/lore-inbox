Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751487AbWDXChL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751487AbWDXChL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 22:37:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751490AbWDXChL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 22:37:11 -0400
Received: from uproxy.gmail.com ([66.249.92.173]:24022 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751487AbWDXChK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 22:37:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=An8o5/7CfidP8MbzS/yOTHO0+1e4hqGJ7tuLYl8hKNdbYA7yJeTYF/RkbQasxK8mgcyif2Uic8Jldt4cFUEGAaZrFoxNbb27pMP7FLiR16yDc09odybJNBowEEYFCZ8GYkDcipNC3NbcDAJ5/wrZYtIkz99jVpg0qYUNCWP0PQA=
Message-ID: <b6fcc0a0604231937h6f2754f9k68ec76dc19c7ddb9@mail.gmail.com>
Date: Sun, 23 Apr 2006 19:37:08 -0700
From: "Alexey Dobriyan" <adobriyan@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: ALSA regression: oops on shutdown
Cc: linux-kernel@vger.kernel.org, perex@suse.cz, alsa-devel@alsa-project.org
In-Reply-To: <20060423185721.39ff4207.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060423235730.GA7934@mipter.zuzino.mipt.ru>
	 <20060423185721.39ff4207.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/23/06, Andrew Morton <akpm@osdl.org> wrote:
> Alexey Dobriyan <adobriyan@gmail.com> wrote:
> >
> > ALSA oops I reported against 2.6.16-rc1-mm4 [1] sneaked into mainline
> >  after release.
>
> One wonders why the ALSA developers merged up which was known to cause
> oopses.

To be fair, I bisected it only to git-alsa.patch back then and only
now found enough time, so
blame me.
