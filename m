Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932209AbWGXQkt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932209AbWGXQkt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 12:40:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932210AbWGXQkt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 12:40:49 -0400
Received: from lucidpixels.com ([66.45.37.187]:42160 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S932209AbWGXQks (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 12:40:48 -0400
Date: Mon, 24 Jul 2006 12:40:47 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34.internal.lan
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17.[1-6] XFS Filesystem Corruption, Where is 2.6.17.7?
In-Reply-To: <Pine.LNX.4.64.0607241224010.10896@p34.internal.lan>
Message-ID: <Pine.LNX.4.64.0607241239460.10990@p34.internal.lan>
References: <Pine.LNX.4.64.0607241224010.10896@p34.internal.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jul 2006, Justin Piszcz wrote:

> Beginning at 2.6.17 to 2.6.17.6, there is a serious XFS bug that results in 
> filesystem corruption, there was a 1 line bugfix patch that was released 
> recently and I was wondering when 2.6.17.7 would be released with that patch? 
> It affected ALL my Linux machines (x86) running XFS and many people on the 
> XFS mailing list who upgraded to 2.6.17.  I understand when there is a root 
> exploit or DoS bug, the kernel is naturally patched by the -stable team and a 
> new version is released immediately.  Does filesystem corruption not 
> constitute an immediate new -stable release of the kernel?
>
>
>

This fix was available as of 2.6.17.2, but not currently in 2.6.17.6...

http://marc.theaimsgroup.com/?l=linux-kernel&m=115315508506996&w=2

I am running all of my machines with this patch and rebooted a couple of
them with KNOPPIX and checked the FS, it seems to be OK now.

Justin.

