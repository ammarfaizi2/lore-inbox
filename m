Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750781AbVIOIDP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750781AbVIOIDP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 04:03:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750821AbVIOIDP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 04:03:15 -0400
Received: from zproxy.gmail.com ([64.233.162.199]:19659 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750781AbVIOIDN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 04:03:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=A8dF8xshmv7P0jfwiiYxCgO03Z+nFzguLxS0ZEsCTWNAzwXugvN8ElNNaOHXp94pS/ZpFk3xxhcyOmk7l3GiHFWrLYiiV3kZ2CmIYlgn25HAvZfADlWelE7VALMKpXIsfFTyx4BMO8J8CNQEgx2VotLBEU0T41irWi/huUSD1Fs=
Message-ID: <1e62d137050915010361d10139@mail.gmail.com>
Date: Thu, 15 Sep 2005 13:03:10 +0500
From: Fawad Lateef <fawadlateef@gmail.com>
Reply-To: fawadlateef@gmail.com
To: ivan.korzakow@gmail.com
Subject: Re: best way to access device driver functions
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <a5986103050915004846d05841@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <a5986103050915004846d05841@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/15/05, Ivan Korzakow <ivan.korzakow@gmail.com> wrote:

> I have a number of functions that used to drive a device on an embedded
> system. Now that we are moving to Linux, these functions are part of the
> kernel space. My question is : what is the best way to access these
> from user space ?
> With a device driver, is it not a problem to implement about 15 commands through
> ioctl in addition to the usual open, close, read write ? It seems a bit
> awkward ...
> 
> Any advice on this will help a lot. Thanks in advance,
> 

Adding ioctl in driver is not a good idea especially for 2.6.x series
kernel, rather use sysfs which is in kernel 2.6.x to support
user/kernel interaction too with other usage .....


-- 
Fawad Lateef
