Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262377AbTJAPNN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 11:13:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262384AbTJAPNN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 11:13:13 -0400
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:61690 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S262377AbTJAPNH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 11:13:07 -0400
Content-Type: text/plain;
  charset="CP 1252"
From: Jesse Pollard <jesse@cats-chateau.net>
To: "kartikey bhatt" <kartik_me@hotmail.com>, paul@clubi.ie
Subject: Re: Can't X be elemenated?
Date: Wed, 1 Oct 2003 10:12:32 -0500
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
References: <Law11-F67ATnLE7P95L00001388@hotmail.com>
In-Reply-To: <Law11-F67ATnLE7P95L00001388@hotmail.com>
MIME-Version: 1.0
Message-Id: <03100110123301.18755@tabby>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 30 September 2003 23:32, kartikey bhatt wrote:
> hey everyone who have joined this thread, my fundamental question have got
> out of scope. I mean to say
>
> 1. Kernel level support for graphics device drivers.

Ok.

> 2. On top of that, one can develop complete lightweight GUI.

don't want it in the kernel (bloat)

> 3. Maybe kernel can provide support for event handling.

already does.

> and I still stick to my opinion that graphics card is a computer resource
> that needs to be managed by OS rather than 3rd party developers.
> Just feeding in patches to provide support for AGP gart and DRI
> is an adhoc solution, a stark immoral choice.
> you don't know my frustration when i got PC and wasn't able to
> run X until i810 agp gart support was available at kernel level.
>
> And if you feel that I am a guy heavily dependent on X that's not true.
> I just mean to say if anything is that kernel level support for graphics
> device drivers.
> And X will be automatically eliminated.

don't need it/already done in the frame buffer.

You CAN also look at the GGI project (http://www.ggi-project.org/)

They have an interesting approach (only slightly superseded by the
framebuffer driver) - They are/were looking at dividing the graphics
resource into its' components. Clock drivers, video registers drivers, GPU
interface drivers, graphic event queue driver. Last time I was looking
(shortly after the framebuffer introduction) they wanted to be able to mix
and match the components to the actual devices on the video board (since
many of them use the same fundamental components) and eliminate the "one
driver one video device" aspect.

It may even be suitable for embeded devices... though I think they kinda
got too large since then.

They also support X.

> and if you are feeling very unhappy about my statement X is bloat,
> I really apologize for that.

Not unhappy, it just indicated a bit of experience lacking.

