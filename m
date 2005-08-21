Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750781AbVHUEQT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750781AbVHUEQT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Aug 2005 00:16:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbVHUEQT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Aug 2005 00:16:19 -0400
Received: from wproxy.gmail.com ([64.233.184.194]:52320 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750781AbVHUEQS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Aug 2005 00:16:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qkTGDlwETYNHsRMxnjjteadp7+gIYJyCsx3CYj+aRgxMJSbZ2OCLMSES39WG5ykxaaX2gC+X1LTGJBkbfM+3ue9zB8LintADjhWOusDWD3aWknUOTSENEi4zFxmvxStuISMlqiH1rQeSLjfBgv6D82A+20XaSM6iZx5i6FfN6bg=
Message-ID: <6bffcb0e050820211645c31a7@mail.gmail.com>
Date: Sun, 21 Aug 2005 06:16:17 +0200
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: Con Kolivas <kernel@kolivas.org>
Subject: Re: Schedulers benchmark - Was: [ANNOUNCE][RFC] PlugSched-5.2.4 for 2.6.12 and 2.6.13-rc6
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <200508211147.39503.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43001E18.8020707@bigpond.net.au>
	 <6bffcb0e05081614498879a72@mail.gmail.com>
	 <6bffcb0e05082018346f073ca4@mail.gmail.com>
	 <200508211147.39503.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/21/05, Con Kolivas <kernel@kolivas.org> wrote:
> On Sun, 21 Aug 2005 11:34, Michal Piotrowski wrote:
> > Hi,
> 
> Hi
> 
> > here are kernbench results:
> 
> Nice to see you using kernbench :)
> 
> > ./kernbench -M -o 128
> > [..]
> > Average Optimal -j 128 Load Run:
> 
> Was there any reason you chose 128? Optimal usually works out automatically
> from kernbench to 4x number_cpus. If I recall correctly you have 4 cpus? Not
> sure what 128 represents.
> 
> Cheers,
> Con
> 

No, I just have 1 pentium 4 with ht ;).

Why I chose 128? I just want very high loads. Now I'll try -j192 and
-j256, but I don't know how does my system survive it.

Regards,
Michal Piotrowski
