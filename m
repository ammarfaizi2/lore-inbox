Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267375AbUITWDl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267375AbUITWDl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 18:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267195AbUITWDk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 18:03:40 -0400
Received: from mail.enyo.de ([212.9.189.167]:24581 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S267375AbUITWD1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 18:03:27 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Paul Jakma <paul@clubi.ie>, Ville Hallivuori <vph@iki.fi>,
       Toon van der Pas <toon@hout.vanvergehaald.nl>,
       Wolfpaw - Dale Corse <admin@wolfpaw.net>, kaukasoi@elektroni.ee.tut.fi,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.27 SECURITY BUG - TCP Local and REMOTE(verified) Denial of Service Attack
References: <002301c498ee$1e81d4c0$0200a8c0@wolf>
	<1095008692.11736.11.camel@localhost.localdomain>
	<20040912192331.GB8436@hout.vanvergehaald.nl>
	<Pine.LNX.4.61.0409130413460.23011@fogarty.jakma.org>
	<Pine.LNX.4.61.0409130425440.23011@fogarty.jakma.org>
	<20040913201113.GA5453@vph.iki.fi>
	<Pine.LNX.4.61.0409141553260.23011@fogarty.jakma.org>
	<1095174633.16990.19.camel@localhost.localdomain>
From: Florian Weimer <fw@deneb.enyo.de>
Date: Tue, 21 Sep 2004 00:03:18 +0200
In-Reply-To: <1095174633.16990.19.camel@localhost.localdomain> (Alan Cox's
	message of "Tue, 14 Sep 2004 16:10:36 +0100")
Message-ID: <87sm9cmwd5.fsf@deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Alan Cox:

> On Maw, 2004-09-14 at 15:55, Paul Jakma wrote:
>> Hmm, yes, I hadnt thought of the attack-mitigating aspects of 
>> graceful restart. Though, without other measures, the session is 
>> still is open to abuse (send RST every second).
>
> Its more than that given port randomization, quite a lot more. Of course
> its much easier to just send "must fragment, size 68" icmp replies and
> guess them that way.

Is this attack documented anywhere?
