Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269566AbUJSQYo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269566AbUJSQYo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 12:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269581AbUJSQUz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 12:20:55 -0400
Received: from jade.aracnet.com ([216.99.193.136]:1427 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S269558AbUJSQTE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 12:19:04 -0400
Date: Tue, 19 Oct 2004 09:18:42 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Matt Mackall <mpm@selenic.com>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Enough with the ad-hoc naming schemes, please
Message-ID: <91110000.1098202721@[10.10.2.4]>
In-Reply-To: <20041018180851.GA28904@waste.org>
References: <20041018180851.GA28904@waste.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I can't help but notice you've broken all the tools that rely on a
> stable naming scheme TWICE in the span of LESS THAN ONE POINT RELEASE.
> 
> In both cases, this could have been avoided by using Marcello's 2.4
> naming scheme. It's very simple: when you think something is "final",
> you call it a "release candidate" and tag it "-rcX". If it works out,
> you rename it _unmodified_ and everyone can trust that it hasn't
> broken again in the interval. If it's not "final" and you're accepting
> more than bugfixes, you call it a "pre-release" and tag it "-pre".
> Then developers and testers and automated tools all know what to
> expect.

Yup - from my point of view, all this did was cause our automated testing 
tools to not test this release at all.

Perhaps we could document whatever the standard is going to be somewhere,
then stick to it.

M.
