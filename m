Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932271AbVHRQDJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932271AbVHRQDJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 12:03:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932272AbVHRQDJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 12:03:09 -0400
Received: from rproxy.gmail.com ([64.233.170.200]:47321 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932271AbVHRQDG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 12:03:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TveUnMZWFzY2B1mXETApu/eSiy1Wd5JMS6TDx7ji8LpnypdBcIpqxI0isIXrE30lD9oRalAbpty+Hc53zBHdPIYqMLIBh++de811Wnz4WZ3CCxGHvzCFaxsxsga2Pq1RFYZ8nGNq38TEMwyyTk0xz1BdeI8XseKTK+VNLuKEOKA=
Message-ID: <5a2cf1f6050818090390ec6a4@mail.gmail.com>
Date: Thu, 18 Aug 2005 18:03:06 +0200
From: jerome lacoste <jerome.lacoste@gmail.com>
To: =?ISO-8859-1?Q?Guillermo_L=F3pez_Alejos?= <glalejos@gmail.com>
Subject: Re: Environment variables inside the kernel?
Cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <4fec73ca050818084467f04c31@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <4fec73ca050818084467f04c31@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[I doubt this is the right list to ask this question.]

On 8/18/05, Guillermo López Alejos <glalejos@gmail.com> wrote:
> Hi,
> 
> I have a piece of code which uses environment variables. I have been
> told that it is not going to work in kernel space because the concept
> of environment is not applicable inside the kernel.
>
> I belive that, but I need to demonstrate it. 

Is it me or does that sound like a school assignment? :)

> I do not know how to
> proof this, perhaps referring to a solid reference about Linux design
> that points to the idea that it has no sense to use environment
> variables in kernel space.
> 
> Do anyone knows about the existence of such document?

No.

But you should be able to answer your question by wondering:
- where environment variables come from? see "man sh" or "man bash"
(in particular ENVIRONMENT section)
- how processes are handled. "man init" (in particular BOOTING section)
- where your kernel space is...

Cheers,

Jerome
