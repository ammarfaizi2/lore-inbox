Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264783AbSJPBZi>; Tue, 15 Oct 2002 21:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264796AbSJPBZi>; Tue, 15 Oct 2002 21:25:38 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:9997 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S264783AbSJPBZh>; Tue, 15 Oct 2002 21:25:37 -0400
Date: Tue, 15 Oct 2002 18:33:51 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: John Levon <levon@movementarian.org>
cc: "David S. Miller" <davem@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [8/7] oprofile - dcookies need to use u32
In-Reply-To: <20021016000623.GA45945@compsoc.man.ac.uk>
Message-ID: <Pine.LNX.4.44.0210151830550.1203-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 16 Oct 2002, John Levon wrote:
> 
> Look OK ? Applies after the previous 7 patches.

Ok, everything applied.

I only have one more comment - my Intel contacts tell me that the people
working on vtune are trying to make it play together somewhat with
oprofile, and that they are already talking to you.

Quite frankly, as long as the vtune user-level tools are all proprietary,
I don't really care all that much about vtune compatibility, but if it
turns out to be easy and convenient we might as well try to be polite
about it (and apparently they've sorted out all the issues with their
kernel-level code, and are happy to do that stuff all GPL'd, but since
it's pretty useless without the tools..).

Thanks,

		Linus

