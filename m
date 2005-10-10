Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751027AbVJJXdR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751027AbVJJXdR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 19:33:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751031AbVJJXdR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 19:33:17 -0400
Received: from xproxy.gmail.com ([66.249.82.205]:58437 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751023AbVJJXdR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 19:33:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QaBe4wd5hISOIcgSo13qWM5Oj6u2/7KVDeAOq7bAgPQ/jU7PZDS+PY7a1kUDTwaUeyp7PcU9q6Ea/8ozTfMhbI8YgdAT+wLGyDQG6ToPgu+RAwNg3Kt7wRSZmJjxLP9zlIvrFjdYwOVcH4CQ9rgbc0FloBtCQF63Wqa1OGOZpsc=
Message-ID: <5bdc1c8b0510101633lc45fbf8gd2677e5646dc6f93@mail.gmail.com>
Date: Mon, 10 Oct 2005 16:33:15 -0700
From: Mark Knecht <markknecht@gmail.com>
To: Daniel Walker <dwalker@mvista.com>
Subject: Re: Latency data - 2.6.14-rc3-rt13
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Lee Revell <rlrevell@joe-job.com>
In-Reply-To: <1128983301.18782.215.camel@c-67-188-6-232.hsd1.ca.comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5bdc1c8b0510101316k23ff64e2i231cdea7f11e8553@mail.gmail.com>
	 <1128977359.18782.199.camel@c-67-188-6-232.hsd1.ca.comcast.net>
	 <5bdc1c8b0510101412n714c4798v1482254f6f8e0386@mail.gmail.com>
	 <5bdc1c8b0510101428o475d9dbct2e9bdcc6b46418c9@mail.gmail.com>
	 <1128980674.18782.211.camel@c-67-188-6-232.hsd1.ca.comcast.net>
	 <5bdc1c8b0510101509w4c74028apb6e69746b1b8b65b@mail.gmail.com>
	 <1128983301.18782.215.camel@c-67-188-6-232.hsd1.ca.comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/05, Daniel Walker <dwalker@mvista.com> wrote:

> > Yes, already that looks interesting. Do I have something going on with
> > acpi? This is before running Jack. I'm in Gnome.There are a lot of
> > these messages, but they've stopped. I suppose the 3997 is the delay?
> > That would coorespond with the info I sent earlier.
>
> I think this is a false reading . Sometimes when a system goes idle it
> will cause interrupt disable latency that isn't real (due to process
> halting) . You could try turning ACPI off if you can , and turn off
> power management ..
>
> Daniel

OK. NO immediate difference with most of the power management stuff
turned off. I'll just let it run a few hours and see if I get an xrun.
If I do I'll look at the logs again and report back.

Thanks for the help. I feel like I've got a chance of spotting something.

Cheers,
Mark
