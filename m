Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261779AbUA3Ojv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 09:39:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261799AbUA3Ojv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 09:39:51 -0500
Received: from hq.pm.waw.pl ([195.116.170.10]:41449 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S261779AbUA3Ojt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 09:39:49 -0500
To: erik@hensema.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: Lindent fixed to match reality
References: <20040129193727.GJ21888@waste.org>
	<slrnc1irnj.2is.erik@bender.home.hensema.net>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Thu, 29 Jan 2004 22:55:36 +0100
In-Reply-To: <slrnc1irnj.2is.erik@bender.home.hensema.net> (Erik Hensema's
 message of "Thu, 29 Jan 2004 20:37:07 +0000 (UTC)")
Message-ID: <m3y8rqh12f.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Hensema <erik@hensema.net> writes:

>> void *foo(void) {
>> 
>>  instead of
>> 
>> void *
>> foo(void) {
>
> You just nicely broke 'find . -name *.c | xargs grep ^foo'.

It was never working with the kernel, so no one can break it.
Just use a little better pattern or use a tool which parses C code.
-- 
Krzysztof Halasa, B*FH
