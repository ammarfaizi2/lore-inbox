Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261872AbVADRdB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261872AbVADRdB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 12:33:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261866AbVADRbx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 12:31:53 -0500
Received: from rproxy.gmail.com ([64.233.170.202]:11173 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261811AbVADRbk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 12:31:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=XmFOfyWGXebHEnEypVgPg0Vzv+OcEaLeVDNLBJnF8L7XvjYhctzvaSVUb56jVQIi6Qx3MJhkNjTF9GOWelZf9HOQ1JhawUpPEspG08yttX/IvEuaNsg5tg2zpwbFDpocxs2BHayUqtu4v/olggXpLH4N9bIwv7vuaetSPVPXyMs=
Message-ID: <5b64f7f0501040931699220ad@mail.gmail.com>
Date: Tue, 4 Jan 2005 12:31:39 -0500
From: Rahul Karnik <deathdruid@gmail.com>
Reply-To: Rahul Karnik <deathdruid@gmail.com>
To: Bill Davidsen <davidsen@tmr.com>
Subject: Re: starting with 2.7
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@stusta.de>,
       Diego Calleja <diegocg@teleline.es>, Willy Tarreau <willy@w.ods.org>,
       wli@holomorphy.com, aebr@win.tue.nl, solt2@dns.toxicfilms.tv,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.96.1050103183503.30038C-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200501032103.j03L33eb004694@laptop11.inf.utfsm.cl>
	 <Pine.LNX.3.96.1050103183503.30038C-100000@gatekeeper.tmr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jan 2005 18:42:24 -0500 (EST), Bill Davidsen <davidsen@tmr.com> wrote:
> On Mon, 3 Jan 2005, Horst von Brand wrote:
> > > APM vs. ACPI - shutdown doesn't reliably power down about half of the
> > > machines I use, and all five laptops have working suspend and non-working
> > > resume. APM seems to be pretty unsupported beyond "use ACPI for that."
> >
> > Many never machines just don't have APM.
> 
> What's your point? I'm damn sure there are more machines with APM than 386
> CPUs, AHA1540 SCSI controllers, or a lot of other supported stuff. Most
> machines which have APM at all have a functional power off capability,
> which is a desirable thing for most people.

The point is not that the kernel should not support APM because it is
superceded by ACPI, but that your laptops do not support APM properly.
Did they work correctly with APM in 2.4? If so, we have a regression;
otherwise complain to the laptop vendor, they do not consider APM to
be a high enough priority.
