Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753177AbWKQVuy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753177AbWKQVuy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 16:50:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753242AbWKQVuy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 16:50:54 -0500
Received: from hu-out-0506.google.com ([72.14.214.229]:58096 "EHLO
	hu-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1753177AbWKQVux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 16:50:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uOaW1hHENongeBabSfCNmknbLl4zpX+pCMg2gmAcJrCo3cvKh78smIXTRlwN5KWdEerD0pJAVDYXK54rnYr/BlAie6qvNaAsB7m+xzxX3YOPUWz9WSC0BHGp9ep1lIxUkmSrmvuX9Weg9RtTnVN98twz90mKRxdCe2WnpDsFL9Y=
Message-ID: <d120d5000611171350g16d6205ke1445bbffa26f2b8@mail.gmail.com>
Date: Fri, 17 Nov 2006 16:50:51 -0500
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "David Brownell" <david-b@pacbell.net>
Subject: Re: [patch 2.6.19-rc6] platform_driver_probe(), can save codespace
Cc: "Greg KH" <greg@kroah.com>,
       "Linux Kernel list" <linux-kernel@vger.kernel.org>
In-Reply-To: <200611171226.57794.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200611162328.47987.david-b@pacbell.net>
	 <200611171048.33086.david-b@pacbell.net>
	 <d120d5000611171111g51f624a6mb9ad694005f690a8@mail.gmail.com>
	 <200611171226.57794.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/17/06, David Brownell <david-b@pacbell.net> wrote:
> On Friday 17 November 2006 11:11 am, Dmitry Torokhov wrote:
>
> > Do we discard __init sections in modules nowadays? I thought we did
> > that only for the kernel image itself.
>
> When did we _not_ discard them for modules?
>

It looks like the first attempts for that appeared in 2.4.19-rc1...

http://www.ussg.iu.edu/hypermail/linux/kernel/0207.0/0477.html

-- 
Dmitry
