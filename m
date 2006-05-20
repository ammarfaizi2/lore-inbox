Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964855AbWETNrV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964855AbWETNrV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 09:47:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964856AbWETNrV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 09:47:21 -0400
Received: from vbn.0050556.lodgenet.net ([216.142.194.234]:46282 "EHLO
	vbn.0050556.lodgenet.net") by vger.kernel.org with ESMTP
	id S964855AbWETNrU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 09:47:20 -0400
Subject: Re: [PATCH] 2.6.16.16 Parameter-controlled mmap/stack randomization
From: Arjan van de Ven <arjan@infradead.org>
To: John Richard Moser <nigelenki@comcast.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <446E6A3B.8060100@comcast.net>
References: <446E6A3B.8060100@comcast.net>
Content-Type: text/plain
Date: Sat, 20 May 2006 15:47:18 +0200
Message-Id: <1148132838.3041.3.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-05-19 at 21:00 -0400, John Richard Moser wrote:
> Any comments on this one?
> 
> I'm trying to control the stack and heap randomization via command-line
> parameters. 

why? this doesn't really sound like something that needs to be tunable
to that extend; either it's on or it's off (which is tunable already),
the exact amount should just be the right value. While I often disagree
with the gnome desktop guys, they have some point when they say that
if you can get it right you shouldn't provide a knob.
(if we would put a knob on everything that is a value in the kernel we'd
have five gazilion knobs)


