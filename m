Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964916AbWCQIJL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964916AbWCQIJL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 03:09:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752568AbWCQIJL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 03:09:11 -0500
Received: from zproxy.gmail.com ([64.233.162.200]:18137 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1752567AbWCQIJK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 03:09:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VxCBplTNG4YlcGwW2LHBSI9ehfHI7ID+d20IoJg9hdyy6egbcdXd7gC/5YWJUaiE9NchVStgsGvXO7Lc7keunPP4WiNi4S2BOnIYl0VHm9dwS53H/NT1RFqK7XrwGEccMyGdf2N6Kv136JMNR1k3FGeMsjthYqacSssbDbgFylY=
Message-ID: <9a8748490603170009s4685c0cpc1b05a410d7a975b@mail.gmail.com>
Date: Fri, 17 Mar 2006 09:09:09 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "kernel@ministry.se" <kernel@ministry.se>
Subject: Re: kernel cache mem bug(?)
Cc: Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GHP.4.44.0603170658530.15349-100000@celeborn.ministry.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200603162042.k2GKgEUR019711@turing-police.cc.vt.edu>
	 <Pine.GHP.4.44.0603170658530.15349-100000@celeborn.ministry.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/17/06, kernel@ministry.se <kernel@ministry.se> wrote:
> > On Thu, 16 Mar 2006 18:41:02 +0100, kernel@ministry.se said:
> > > [X.] Other notes, patches, fixes, workarounds:
> >
> > >     Workaround: When we disable HyperThreading in BIOS, this
> > >     problem goes away. We re-enabling HT, it comes back...
> >
> > Have you ruled out marginal memory, or overclocking/overheating?
>
> No overclocking done, no overheating happening. All RAM memory checks
> turn out just fine, with and without HT.
>

When you say "All RAM memory checks turn out just fine" do you mean
the BIOS memory checks or something else?

For a proper memory test run memtest86 (http://www.memtest86.com/)
and/or memtest86+ (http://www.memtest.org/) overnight (some 8-12hours
or more) with all tests enabled.. If the machine survives without
errors that then you can be reasonably sure memory is OK... The BIOS
tests are more or less worthless.


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
