Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266227AbUGJMMq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266227AbUGJMMq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 08:12:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266237AbUGJMMq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 08:12:46 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:12498 "EHLO scrub.home")
	by vger.kernel.org with ESMTP id S266227AbUGJMMd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 08:12:33 -0400
Date: Sat, 10 Jul 2004 14:11:44 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Linus Torvalds <torvalds@osdl.org>
cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Herbert Xu <herbert@gondor.apana.org.au>,
       Chris Wright <chrisw@osdl.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, sds@epoch.ncsc.mil, jmorris@redhat.com,
       mika@osdl.org
Subject: Re: [PATCH] Use NULL instead of integer 0 in security/selinux/
In-Reply-To: <Pine.LNX.4.58.0407092313410.1764@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0407101410310.20635@scrub.home>
References: <E1BiPKz-0008Q7-00@gondolin.me.apana.org.au>
 <Pine.LNX.4.58.0407072214590.1764@ppc970.osdl.org> <m1fz80c406.fsf@ebiederm.dsl.xmission.com>
 <Pine.LNX.4.58.0407092313410.1764@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 9 Jul 2004, Linus Torvalds wrote:

> What's considered bad form is:
>  - assignments in boolean context (because of the confusion of "=" and 
>    "==")

gcc already warns about this, what value has this extra stuff?

bye, Roman
