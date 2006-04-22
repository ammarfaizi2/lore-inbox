Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751176AbWDVUmA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751176AbWDVUmA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 16:42:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751184AbWDVUl7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 16:41:59 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:28112 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751168AbWDVUl5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 16:41:57 -0400
Date: Sat, 22 Apr 2006 13:25:53 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: What's in git.git
In-Reply-To: <7vzmieo2j3.fsf@assigned-by-dhcp.cox.net>
Message-ID: <Pine.LNX.4.63.0604221318500.30863@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vzmieo2j3.fsf@assigned-by-dhcp.cox.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 21 Apr 2006, Junio C Hamano wrote:

>   - diff --stat: do not drop rename information.
> 
>     Johannes suggested "file => /dev/null" to show a deleted
>     file as if a rename was done.  While I think it makes some
>     sense, I am afraid it diverges too much from the traditional
>     diffstat output.  I am undecided, somewhat negative, about
>     the suggestion.

It was not so much a suggestion, but a misinterpretation of your patch. I 
am also undecided and slightly negative about it.

> * The 'pu' branch, in addition, has these.
> 
>   - gitk: Fix geometry on rootless X (Johannes Schindelin)

I talked to Paul about this, and was not only slightly negative about it. 
The suggestion was to either use native versions of Tk (which might or 
might not fix it), or fix Tk.

Having spent already some time with this workaround, I am not willing to 
invest more of it, though.

So, if people want to do something about this patch, go wild.

Ciao,
Dscho

