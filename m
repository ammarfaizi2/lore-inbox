Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316789AbSHBUH0>; Fri, 2 Aug 2002 16:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316795AbSHBUH0>; Fri, 2 Aug 2002 16:07:26 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:19219 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316789AbSHBUH0>; Fri, 2 Aug 2002 16:07:26 -0400
Date: Fri, 2 Aug 2002 13:10:48 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Dave McCracken <dmccr@us.ibm.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.5.30] Allow tasks to share credentials
In-Reply-To: <200208022006.g72K6ctD012092@baldur.austin.ibm.com>
Message-ID: <Pine.LNX.4.33.0208021309200.2466-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 2 Aug 2002, Dave McCracken wrote:
> 
> This patch allows tasks to optionally share credentials, selectable
> via a flag to clone().

This still has the "security hole you can run a slow-moving bight yellow
truck with flashing lights on through" problem..

		Linus

