Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265975AbTGAFuI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 01:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265985AbTGAFuI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 01:50:08 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:24450 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S265975AbTGAFuC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 01:50:02 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Joshua Kwan <joshk@triplehelix.org>
Subject: Re: [PATCH] O1int 0307010922 for 2.5.73 interactivity
Date: Tue, 1 Jul 2003 16:07:52 +1000
User-Agent: KMail/1.5.2
References: <20030701010412.GA21496@triplehelix.org> <200307011210.31612.kernel@kolivas.org> <20030701044115.GA22902@triplehelix.org>
In-Reply-To: <20030701044115.GA22902@triplehelix.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307011607.52022.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Jul 2003 14:41, Joshua Kwan wrote:
> On Tue, Jul 01, 2003 at 12:10:31PM +1000, Con Kolivas wrote:
> > Well we're on the way. Sing with me... a tweaking we will go..
> > Here is a tweaked patch with small changes otherwise which should help.
> >
> > P.S. Were you running 100Hz?
> > Con
>
> Yes, and with this patch coupled with reversing andrew's 100hz patch,
> makes the skips largely disappear.
>
> Or could it be that 1000hz alone fixes everything? Who knows...

Great thanks. I'll try my best to leave it alone for a while now and let 
others test it (no 1000Hz alone does not fix this problem).

I'll leave the latest available O1int patch here:
http://kernel.kolivas.org/2.5

for downloading and remind people that if you use the -mm tree you will see 
better performance if you reverse patch the 100Hz patch, but it still should 
benefit at 100Hz.

Con

