Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423085AbWBBHLb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423085AbWBBHLb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 02:11:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423088AbWBBHLb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 02:11:31 -0500
Received: from uproxy.gmail.com ([66.249.92.197]:9298 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1423085AbWBBHLa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 02:11:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ImCcvLPn+yrSFZZTYl/jcLWUuWyAUG2ORaJhGI4vN6Gh4HNa6bZ9Swp64DVi9m8G4GLdJgmG/XryazDUSgsiz/ZrSlJxzokD8oVx4x2HuqYxC8AxbQFTQkt5Ubawq1I084gVarGCuP/pJV3cw6CBoQiSCRIe+U3uz3u3ZLNZrOc=
Message-ID: <84144f020602012311g6a2fd0f9v56fc903ad25867e@mail.gmail.com>
Date: Thu, 2 Feb 2006 09:11:28 +0200
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.16rc1-git4 slab corruption.
In-Reply-To: <20060202050713.GA2560@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060131180319.GA18948@redhat.com>
	 <20060202050713.GA2560@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/2/06, Dave Jones <davej@redhat.com> wrote:
> I just hit corruption again (I had rebooted since), but this time with
> a completely different trace.

[snip, snip]

> What I find interesting here is the corruption pattern is the same both times.
> Strange, and very scary.

Did you try out the slab verifier? The patch I sent now applies to
latest -linus.

                            Pekka
