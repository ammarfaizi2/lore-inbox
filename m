Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261840AbVCVUDt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261840AbVCVUDt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 15:03:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261817AbVCVUBz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 15:01:55 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:2734 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261790AbVCVUA2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 15:00:28 -0500
Date: Tue, 22 Mar 2005 21:00:24 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Blaisorblade <blaisorblade@yahoo.it>
cc: kbuild-devel@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Bug with multiple help messages, the last one is shown
In-Reply-To: <200503221832.41883.blaisorblade@yahoo.it>
Message-ID: <Pine.LNX.4.61.0503222057580.25131@scrub.home>
References: <200503221832.41883.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 22 Mar 2005, Blaisorblade wrote:

> I've verified multiple times that if we have a situation like this
> 
> bool A
> depends on TRUE
> help
>   Bla bla1
> 
> and
> 
> bool A
> depends on FALSE
> help
>   Bla bla2
> 
> even if the first option is the displayed one, the help text used is the one 
> for the second option (the absence of "prompt" is not relevant here)!

Is this based on a real problem? I know that there's currently one help 
text per symbol and the behaviour for multiple help texts is basically 
undefined.

bye, Roman
