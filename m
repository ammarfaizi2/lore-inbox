Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030209AbWHDJEj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030209AbWHDJEj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 05:04:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030224AbWHDJEj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 05:04:39 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:672 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030209AbWHDJEi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 05:04:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=O4Z58RxmlCF0f5+y2V4+p2Cej9bUqXarWGSpVcFtkm6IrprC+pNVoadto4P7aOc0v/NX+P2IKf5xfPX8tmrw+o/BNTXkL97oN/4/WWuIdyuDaou/ECJnQMIWFoOzRKAopRob2FY7w62PZzdogrJcRcSd6yUJPCYm0plO7HxX+78=
Message-ID: <9a8748490608040204o58f7f594qe8c3316fcdf00ea4@mail.gmail.com>
Date: Fri, 4 Aug 2006 11:04:36 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Greg KH" <gregkh@suse.de>
Subject: Re: [patch 00/23] -stable review
Cc: linux-kernel@vger.kernel.org, stable@kernel.org,
       "Justin Forbes" <jmforbes@linuxtx.org>,
       "Zwane Mwaikambo" <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, "Randy Dunlap" <rdunlap@xenotime.net>,
       "Dave Jones" <davej@redhat.com>,
       "Chuck Wolber" <chuckw@quantumlinux.com>,
       "Chris Wedgwood" <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk
In-Reply-To: <20060804053807.GA769@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060804053807.GA769@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/08/06, Greg KH <gregkh@suse.de> wrote:
> This is the start of the stable review cycle for the 2.6.17.8 release.
> There are 23 patches in this series, all will be posted as a response to
> this one.  If anyone has any issues with these being applied, please let
> us know.  If anyone is a maintainer of the proper subsystem, and wants
> to add a Signed-off-by: line to the patch, please respond with it.
>
> These patches are sent out with a number of different people on the Cc:
> line.  If you wish to be a reviewer, please email stable@kernel.org to
> add your name to the list.  If you want to be off the reviewer list,
> also email us.
>
> Responses should be made by Sunday, August 6, 05:00:00 UTC.  Anything
> received after that time might be too late.
>
> I've also posted a roll-up patch with all changes in it if people want
> to test it out.  It can be found at:
>
>         kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.17.8-rc1.gz
>

Any chance that the fixes in the (latest) e1000 driver version
7.1.9-k4 will get backported?

I can't run 2.6.17.7 on at least one of my servers due to bugs in the
driver that are fixed in the latest e1000 version.
I looked through the -stable patches but didn't find anything that
would fix my problem.
I get messages along the lines of "kernel: Virtual device XXX asks to
queue packet!" and the device then refuses to work.
The last kernel where I know for a fact that it worked OK is 2.6.11,
so that's what the server is currently running.

Getting the fix for that problem backported to -stable would really make my day.


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
