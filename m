Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262776AbTLJOa4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 09:30:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262991AbTLJOa4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 09:30:56 -0500
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:29175 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S262776AbTLJOay
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 09:30:54 -0500
Content-Type: text/plain;
  charset="CP 1252"
From: Jesse Pollard <jesse@cats-chateau.net>
To: Dale Whitchurch <dalew@sealevel.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux GPL and binary module exception clause?
Date: Wed, 10 Dec 2003 08:30:30 -0600
X-Mailer: KMail [version 1.2]
References: <000701c3be1c$8a3cfbc0$0301a8c0@comcast.net> <200312091322.33506.andrew@walrond.org> <1070979148.16262.63.camel@oktoberfest>
In-Reply-To: <1070979148.16262.63.camel@oktoberfest>
MIME-Version: 1.0
Message-Id: <03121008303002.31567@tabby>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 09 December 2003 08:12, Dale Whitchurch wrote:
> A question for this thread:
>
> Is the GPL in effect for the kernel so that anybody can enhance the
> current drivers and add support for any other device?  If two companies
> develop competing products and those products (albeit a few slight
> differences) perform the same operations using almost the same hardware,
> do we want one company to use the others driver?

Sort of. Why not? Especially if the driver is GPL.

> In another sense, does the kernel evolve to reflect this?

It evolves to promote standards. If both can use the same driver, then each
(if they both contribute) will reduce the development cost of the driver
by 1/n, where n is the number of manufacturs of similar boards.

>  If the
> overall driver acts the same minus a few hardware differences, does the
> kernel source change by abstracting the similarities and allow both
> companies to write the device specific code?

Yes. One project that tries to do this for graphics is the GGI. They try to
separate the display control registers, timing registers, and data interfacing
to allow a mix-n-match the various drivers to come up with a unique 
combination that would work for a variety of boards. 

>  Does it instead say that
> both cards must have independent source code?  Or do we only allow the
> first driver into the source tree?

This is a combined result. Usually the first one is a specific driver for
each device. If the drivers are GPL, somebody else may combine them, or the
second manufacturer may take the first driver, make some changes, and release
(under GPL) the modified driver. Then both manufacturers (or their engineers)
may collaborate to come up with a single driver.

Yes. The multiple mice implementations are an example. So are IDE drivers.

> There are no evil overtones in this email, nor any disgruntled developer
> feelings.  I am just reading at this thread and asking myself, "Is the
> overall goal for everyone to get along?"

Yup. Everybody contributing. Everybody benifiting.
