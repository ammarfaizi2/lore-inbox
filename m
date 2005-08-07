Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752537AbVHGSqv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752537AbVHGSqv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 14:46:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752538AbVHGSqv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 14:46:51 -0400
Received: from rproxy.gmail.com ([64.233.170.205]:19612 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1752537AbVHGSqu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 14:46:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bmc0uA2oRGLZkFVzPnsLyqd+Xv103JD0cyKbR1aJU+l9qFUNGpPFrLicxgO3Ith0JfTZfEgYB1w23PQmlmLx4EHv4yKuaYjFHbV0HCix3MFzv78XreuhN5syadSfzKhgGUQ3sMC0CNPAaVsQso1lShx2DsfGepWQFBGf9YNZDc0=
Message-ID: <5348b8ba050807114616f84ee6@mail.gmail.com>
Date: Sun, 7 Aug 2005 14:46:50 -0400
From: Erick Turnquist <jhujhiti@gmail.com>
To: Tim Hockin <thockin@hockin.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Lost Ticks on x86_64
In-Reply-To: <20050807174811.GA31006@hockin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5348b8ba050806204453392f7f@mail.gmail.com.suse.lists.linux.kernel>
	 <p73mznuc732.fsf@bragg.suse.de> <20050807174811.GA31006@hockin.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Some BIOSes do not lock SMM, and you *could* turn it off at the chipset
> level.

I don't see anything about SMM in my BIOS configuration even with the
advanced options enabled... Turning it off at the chipset level sounds
like a hardware hack - is it?

The gettimeofday patch for 2.6.13-rc3 won't apply. My source tree has
no ntp.h or ntp.c, and I get a malformed patch error at line 560. I'm
using the patch Google found for me: http://lwn.net/Articles/143953/
on a 2.6.13-rc3 source tree.
