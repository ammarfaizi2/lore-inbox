Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965154AbWJBRYg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965154AbWJBRYg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 13:24:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965152AbWJBRYf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 13:24:35 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:182 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S965154AbWJBRYe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 13:24:34 -0400
Subject: Re: Spam, bogofilter, etc
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "Martin J. Bligh" <mbligh@mbligh.org>, Lee Revell <rlrevell@joe-job.com>,
       Matti Aarnio <matti.aarnio@zmailer.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0610020933020.3952@g5.osdl.org>
References: <1159539793.7086.91.camel@mindpipe>
	 <20061002100302.GS16047@mea-ext.zmailer.org>
	 <1159802486.4067.140.camel@mindpipe> <45212F39.5000307@mbligh.org>
	 <Pine.LNX.4.64.0610020933020.3952@g5.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 02 Oct 2006 18:49:52 +0100
Message-Id: <1159811392.8907.36.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-10-02 am 09:40 -0700, ysgrifennodd Linus Torvalds:
> If you want a yes/no kind of thing, do it on real hard issues, like not 
> accepting email from machines that aren't registered MX gateways. Sure, 
> that will mean that people who just set up their local sendmail thing and 
> connect directly to port 25 will just not be able to email, but let's face 
> it, that's why we have ISP's and DNS in the first place.

Except most of the ISPs are incompetent and many people have to run
their own mail system in order to get mail that actually *works*. I've
had that experience several times, although thankfully I now have a sane
ISP.

MX checking is as broken or more broken than bayes.

There is another reason bayes is not very good too - every good spammer
reruns their message through spamassassin adding random text till they
get a good score *then* they spew it out.

Alan
