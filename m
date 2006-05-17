Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751115AbWEQU6Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751115AbWEQU6Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 16:58:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751117AbWEQU6Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 16:58:25 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:20356 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751115AbWEQU6Z convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 16:58:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=XD6X5y3wd5zqf3ctoKU4JF5og95D/GxVHpVSOPnJatKsla85FtVO0ifM9mPJSuvNk0cficSbp5/5NloFw5UXWI173m6LkyXGsw+9GZFXag4RfCpvaqaWHFaOoHbd9wLpx3jSGMO6WZ3kYxO/m4ms/lP4HGBHKk+HEF6IDSEXuxE=
Message-ID: <eada2a070605171358r1fea2c62u641b6308e78aa1e4@mail.gmail.com>
Date: Wed, 17 May 2006 13:58:23 -0700
From: "Tim Pepper" <lnxninja@us.ibm.com>
To: viro@zeniv.linux.org.uk
Subject: Re: Too many levels of symbolic links
Cc: linux-kernel@vger.kernel.org, "Linda Walsh" <lkml@tlinx.org>,
       "Brian D. McGrew" <brian@visionpro.com>,
       "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <e3966u$dje$1@terminus.zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <14CFC56C96D8554AA0B8969DB825FEA0012B309B@chicken.machinevisionproducts.com>
	 <44580CF2.7070602@tlinx.org> <e3966u$dje$1@terminus.zytor.com>
X-Google-Sender-Auth: 57a865920451bb38
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/2/06, H. Peter Anvin <hpa@zytor.com> wrote:
> By author:    Linda Walsh <lkml@tlinx.org>
> > Is this what you are looking for?
> > include/linux/namei.h    MAX_NESTED_LINKS = 5
> > (used in fs/namei.c, where comment claims MAX_NESTING is equal to 8)
>
> Wonder if it would make sense to make this a sysctl...

There might be something in somebody's pipeline around this...Early
this year Al Viro said (http://lkml.org/lkml/2006/2/12/104) he was
going to bump it post 2.6.16 back up to 8 to match the comment.

Al:  In the thread referenced above you'd said you would if there
wasn't any major complaint and it didn't seem like any surfaced.  Are
you still planning to up MAX_NESTED_LINKS?


Tim
