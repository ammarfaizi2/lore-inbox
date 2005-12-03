Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932112AbVLCRwB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932112AbVLCRwB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 12:52:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932113AbVLCRwB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 12:52:01 -0500
Received: from mx1.suse.de ([195.135.220.2]:34948 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932112AbVLCRwA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 12:52:00 -0500
To: Keith Mannthey <kmannth@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Only one processor detected in 8-Way opteron in 32-bit mode
References: <c775eb9b0512011315y40bdbf30w172583cd85e92fa6@mail.gmail.com>
	<a762e240512011527s69053b8eg13ec4674c3e36b07@mail.gmail.com>
	<c775eb9b0512011651kb0e1cb4xf79ca20372f6d76e@mail.gmail.com>
	<c775eb9b0512011712x2f4f2f44t4cd11d5d6f60a9d8@mail.gmail.com>
	<a762e240512011742p681df3bdic16598a85926dd67@mail.gmail.com>
	<c775eb9b0512020732v3f41f91fpb3b4b61b0b539d92@mail.gmail.com>
	<a762e240512021407p5a31c0daid902352625701ca2@mail.gmail.com>
From: Andi Kleen <ak@suse.de>
Date: 03 Dec 2005 15:21:14 -0700
In-Reply-To: <a762e240512021407p5a31c0daid902352625701ca2@mail.gmail.com>
Message-ID: <p73psod4yat.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Mannthey <kmannth@gmail.com> writes:

> Welcome to hardware bring up.  Ok I looked a little closer at the
> story.  In x86_64 the only check for valid apic is apicid < MAX_APICS
> which make sense to me.

It will still not work. He will need a variant of the physflat-i386 
patch I posted some time ago. However it needs some cleanup
to be actually mergeable

My recommendation is a 64bit kernel.

-Andi
