Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932071AbWEMR31@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbWEMR31 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 13:29:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932106AbWEMR31
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 13:29:27 -0400
Received: from wr-out-0506.google.com ([64.233.184.228]:10346 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932071AbWEMR30 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 13:29:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tj1/WHi8dOI1C8Dff+R6EREWpFd/iIsFxluYQCaVlus04e2B+c38TkVhPn2oVcSTFSjJ9jRtLiOZ7iEx8fKNMw/SCWx1z2KG7ygHiOBckHqgdcS+BNnn2SzGThKRjpUv2Zhrt9sbKnBLshMruQsdj1AKkrhXRagSJTQrLqkiq5s=
Message-ID: <7c3341450605131029l194174f3v7339dce0e234b555@mail.gmail.com>
Date: Sat, 13 May 2006 18:29:25 +0100
From: "Nick Warne" <nick.warne@gmail.com>
Reply-To: nick@linicks.net
To: "Adrian Bunk" <bunk@stusta.de>
Subject: Re: Linux 2.6.16.16
Cc: "Ingo Oeser" <ioe-lkml@rameria.de>, "Chris Wright" <chrisw@sous-sol.org>,
       "Maciej Soltysiak" <solt2@dns.toxicfilms.tv>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060513155610.GB6931@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <20060511022547.GE25010@moss.sous-sol.org>
	 <296295514.20060511123419@dns.toxicfilms.tv>
	 <20060511173312.GI25010@moss.sous-sol.org>
	 <200605131735.20062.ioe-lkml@rameria.de>
	 <20060513155610.GB6931@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/05/06, Adrian Bunk <bunk@stusta.de> wrote:
> The CVE should be enough for easily getting all information you
> requested.
>
> Information whether it's a DoS or a root exploit is helpful, but any
> qualified person doing risk management will anyways lookup the CVE.

Well, yes, but some people do *actually* use the latest kernel at home
and not in labs (et al), and as Maciej asked, we are not sure whether
the (whatever) latest patch is needed or not on whatever our current
config is the way the latest stable fixes are announced.

"    [PATCH] fs/locks.c: Fix lease_init (CVE-2006-1860)

    It is insane to be giving lease_init() the task of freeing the lock it is
    supposed to initialise, given that the lock is not guaranteed to be
    allocated on the stack. This causes lockups in fcntl_setlease().
    Problem diagnosed by Daniel Hokka Zakrisson <daniel@hozac.com>

    Also fix a slab leak in __setlease() due to an uninitialised return value.
    Problem diagnosed by BjÃ¶rn Steinbrink.
"

OK, great.  But what does it mean?

It would be nice to have a short explanation of what the fix is for in
real world terms.

Nick
