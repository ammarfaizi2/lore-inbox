Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290228AbSAPBgR>; Tue, 15 Jan 2002 20:36:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288633AbSAPBgH>; Tue, 15 Jan 2002 20:36:07 -0500
Received: from zero.tech9.net ([209.61.188.187]:14600 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S290228AbSAPBf4>;
	Tue, 15 Jan 2002 20:35:56 -0500
Subject: Re: [PATCH] Re: 2.5.3-pre1 compile error
From: Robert Love <rml@tech9.net>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020115202518.M17477@redhat.com>
In-Reply-To: <20020115192048.G17477@redhat.com>
	<Pine.LNX.4.33.0201151628440.1140-100000@penguin.transmeta.com>
	<20020115194316.I17477@redhat.com> <1011144263.8754.22.camel@phantasy> 
	<20020115202518.M17477@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 15 Jan 2002 20:39:20 -0500
Message-Id: <1011145160.8754.37.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-01-15 at 20:25, Benjamin LaHaise wrote:

> Uh, brlock.c probably should be including threads.h...

lib/brlock.c includes include/linux/sched.h which includes
include/linux/threads.h ...

	Robert Love

