Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315457AbSGEGya>; Fri, 5 Jul 2002 02:54:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315472AbSGEGy3>; Fri, 5 Jul 2002 02:54:29 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:57033 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S315457AbSGEGy3>; Fri, 5 Jul 2002 02:54:29 -0400
Date: Fri, 5 Jul 2002 08:56:59 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Andrew Rodland <arodland@noln.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [OKS] O(1) scheduler in 2.4
In-Reply-To: <20020705021827.713e4cc6.arodland@noln.com>
Message-ID: <Pine.NEB.4.44.0207050840140.14934-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Jul 2002, Andrew Rodland wrote:

>...
> Very nearly off topic, but I've had a few people on IRC tell me that
> they love O(1) specifically because it has a 'nice that actually does
> something'. As a matter of fact, I've had to change my X startup
> scripts, to make it a bit less selfish; the defaults are just plain
> silly, now.
>...

This is exactly a reason why O(1) shouldn't go into 2.4:

E.g. my X is as suggested by my the installation routine of my
distribution (Debian unstable/testing) niced to -10. It would be a bad
surprise for _many_ people if they upgrade their 2.4 kernel because of
other security and/or stability fixes and such a setting is then wrong.


cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox



