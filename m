Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755342AbWKMUzn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755342AbWKMUzn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 15:55:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755344AbWKMUzm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 15:55:42 -0500
Received: from sd291.sivit.org ([194.146.225.122]:42250 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S1755342AbWKMUzl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 15:55:41 -0500
Subject: Re: [PATCH] Apple Motion Sensor driver
From: Stelian Pop <stelian@popies.net>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Jean Delvare <khali@linux-fr.org>,
       Dmitry Torokhov <dmitry.torokhov@gmail.com>,
       Andrew Morton <akpm@osdl.org>,
       Michael Hanselmann <linux-kernel@hansmi.ch>,
       "Aristeu S. Rozanski F." <aris@cathedrallabs.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Paul Mackerras <paulus@samba.org>, Robert Love <rml@novell.com>,
       Rene Nussbaumer <linux-kernel@killerfox.forkbomb.ch>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1163441931.5399.16.camel@johannes.berg>
References: <1163280972.32084.13.camel@localhost.localdomain>
	 <d120d5000611130704r258c8946p3994c5ba1e0187e9@mail.gmail.com>
	 <1163431758.23444.8.camel@localhost.localdomain>
	 <d120d5000611130753p172c2a69n260482052f623a46@mail.gmail.com>
	 <1163434455.23444.14.camel@localhost.localdomain>
	 <1163434826.2805.2.camel@ux156>
	 <20061113191444.1519bdb9.khali@linux-fr.org>
	 <1163441931.5399.16.camel@johannes.berg>
Content-Type: text/plain; charset=ISO-8859-15
Date: Mon, 13 Nov 2006 21:55:35 +0100
Message-Id: <1163451335.23807.22.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le lundi 13 novembre 2006 à 19:18 +0100, Johannes Berg a écrit :

> Thing is, there's simply no clear standard for accelerometer input
> devices. If the left side of my input device (read powerbook here) is
> lower, does the mouse cursor 'fall' with gravity, or does it 'float' up?
> Neverball apparently expects it to fall with gravity.

So let's make neverball happy ! Hacker productivity depends on it :)

The latest incarnation of ams I posted somewhere in this thread adds an
invert option like done in hdaps. I haven't switched the data on the Z
axis though, not sure if it makes any sense to do it.

-- 
Stelian Pop <stelian@popies.net>

