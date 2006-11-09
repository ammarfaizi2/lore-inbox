Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423982AbWKIBIt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423982AbWKIBIt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 20:08:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423985AbWKIBIs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 20:08:48 -0500
Received: from palrel11.hp.com ([156.153.255.246]:8339 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S1423982AbWKIBIr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 20:08:47 -0500
Subject: Re: 2.6.19-rc1: Volanomark slowdown
From: Rick Jones <rick.jones2@hp.com>
To: Olaf Kirch <okir@suse.de>
Cc: Tim Chen <tim.c.chen@linux.intel.com>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       davem@sunset.davemloft.net, kuznet@ms2.inr.ac.ru,
       netdev@vger.kernel.org
In-Reply-To: <20061108221028.GA16889@suse.de>
References: <1162924354.10806.172.camel@localhost.localdomain>
	 <1163001318.3138.346.camel@laptopd505.fenrus.org>
	 <20061108162955.GA4364@suse.de>
	 <1163011132.10806.189.camel@localhost.localdomain>
	 <20061108221028.GA16889@suse.de>
Content-Type: text/plain
Date: Wed, 08 Nov 2006 17:08:47 -0800
Message-Id: <1163034527.5931.56.camel@raj-laptop>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-08 at 23:10 +0100, Olaf Kirch wrote:
> What I'm saying though is that it doesn't rhyme with what I've seen of
> Volanomark - we ran 2.6.16 on a 4p Intel box for instance and it didn't
> come close to saturating a Gigabit pipe before it maxed out on CPU load.

That actually supports the hypothesis doesn't it?  The issue being the
increased number of ACKs causing additional CPU overhead not saturating
a NIC if any involved.

One of these days I may have to try to look more closely at what volano
does relative to netperf - I remember that someone tried very hard (was
it you alexy?) to show a perfomance effect with netperf and it didn't do
it :(

rick jones

