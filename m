Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751776AbWCUPdl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751776AbWCUPdl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 10:33:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751777AbWCUPdl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 10:33:41 -0500
Received: from uproxy.gmail.com ([66.249.92.207]:64023 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751776AbWCUPdk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 10:33:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eLf38g9e+4wjDTXzMnZBh37i5BaFrvvfY08kKqt2lcHD2UnWMLiG2cp+FtuMaqZiRosDftXp/blfrrhFYisR6R0TuNWAEPFog68ci+WV01uyxsq0/VQoYvtzED48Qj/wtUP9eo338JeeiygkM2Z0mAtQ0l1xkcr1bWZETgC53yU=
Message-ID: <bc56f2f0603210733vc3ce132p@mail.gmail.com>
Date: Tue, 21 Mar 2006 10:33:36 -0500
From: "Stone Wang" <pwstone@gmail.com>
To: "Nick Piggin" <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH][5/8] proc: export mlocked pages info through "/proc/meminfo: Wired"
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <441FEFC7.5030109@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <bc56f2f0603200537i7b2492a6p@mail.gmail.com>
	 <441FEFC7.5030109@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The list potentially could have more wider use.

For example, kernel-space locked/pinned pages could be placed on the list too
(while mlocked pages are locked/pinned by system calls from user-space).

2006/3/21, Nick Piggin <nickpiggin@yahoo.com.au>:
> Stone Wang wrote:
> > Export mlock(wired) info through file /proc/meminfo.
> >
>
> If wired is solely for mlock pages... why not just call it
> mlock/mlocked?
>
> --
> SUSE Labs, Novell Inc.
>
> Send instant messages to your online friends http://au.messenger.yahoo.com
>
>
