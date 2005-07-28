Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261553AbVG1PFr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261553AbVG1PFr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 11:05:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261547AbVG1PDt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 11:03:49 -0400
Received: from zproxy.gmail.com ([64.233.162.206]:33245 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261552AbVG1PD1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 11:03:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=a7q2aGn3BDmKkolCxg75tbxhthaUWhaN8p3tOiKe5dp8yziobi4n9IP4zfKhv9aniTgCAiPLeRA+OMR9tp5SAfdoE2tJ8QWunvRTGTVlQSpWaiZRRXRwRhOaMEAi6Zms+KIhSfWiC96X8bIyXKIRW3UNqMJOD1rvARrgAE6WpoM=
Message-ID: <3b0ffc1f05072808024968324@mail.gmail.com>
Date: Thu, 28 Jul 2005 11:02:48 -0400
From: Kevin Radloff <radsaq@gmail.com>
Reply-To: Kevin Radloff <radsaq@gmail.com>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: ACPI processor C-state regression in 2.6.13-rc3?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050728145254.GL3528@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <3b0ffc1f05071309396353066b@mail.gmail.com>
	 <20050728145254.GL3528@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/28/05, Adrian Bunk <bunk@stusta.de> wrote:
> On Wed, Jul 13, 2005 at 12:39:13PM -0400, Kevin Radloff wrote:
> 
> > With the ACPI merge in 2.6.13-rc3, C2 and C3 processor states are no
> > longer detected/enabled on my Fujitsu Lifebook P7010D. Enabling ACPI
> > debugging doesn't result in any extra info about this being reported.
> > I assume it's related to the changes to enable C2/3 on SMP..
> >
> > Please CC me with any followups, as I'm not on the list.
> 
> Is this problem still present in 2.6.13-rc3-mm3?
> 
> If yes, please file a bug report at the kernel Bugzilla [1].

I just downloaded the 2.6.13-rc3-mm3 patch and I see the fix in there.

-- 
Kevin 'radsaq' Radloff
radsaq@gmail.com
http://saqataq.us/
