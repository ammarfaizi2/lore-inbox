Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262022AbVGLTJK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262022AbVGLTJK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 15:09:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262258AbVGLTJJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 15:09:09 -0400
Received: from mf01.sitadelle.com ([212.94.174.68]:54381 "EHLO
	smtp.cegetel.net") by vger.kernel.org with ESMTP id S262022AbVGLTJG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 15:09:06 -0400
Message-ID: <42D41545.7040809@lifl.fr>
Date: Tue, 12 Jul 2005 21:08:53 +0200
From: Eric Piel <Eric.Piel@lifl.fr>
Organization: LIFL
User-Agent: Mozilla Thunderbird 1.0.2-3mdk (X11/20050322)
X-Accept-Language: en, fr, ja, es
MIME-Version: 1.0
To: Jim Nance <jlnance@sdf.lonestar.org>
Cc: Peter Staubach <staubach@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Kernel header policy
References: <200507120206.j6C26kGY017571@laptop11.inf.utfsm.cl> <42D3C51D.3020703@redhat.com> <20050712183859.GA21230@SDF.LONESTAR.ORG>
In-Reply-To: <20050712183859.GA21230@SDF.LONESTAR.ORG>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

12.07.2005 20:38, Jim Nance wrote/a écrit:
> 
> 
> Perhaps a little history would help.  In the beginning, the kernel was
> written with the intention that userland would be including the headers.
> And libc did include the kernel headers.
> 
> This did provide an effective way to get new kernel features to show
> up in userland, but it created all sorts of other problems.  Eventually
> it was decided/decreed that userland would NOT include kernel headers.
> Instead, libc would provide a set of headers which would either be
> compatable, or would marshel data into the form the kernel wanted.
>  

So does this mean that all the "#ifdef __KERNEL__" are useless or are 
they still used?

Eric
