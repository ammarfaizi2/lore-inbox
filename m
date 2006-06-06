Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932196AbWFFOng@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932196AbWFFOng (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 10:43:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932200AbWFFOng
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 10:43:36 -0400
Received: from caffeine.uwaterloo.ca ([129.97.134.17]:29928 "EHLO
	caffeine.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S932196AbWFFOnf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 10:43:35 -0400
Date: Tue, 6 Jun 2006 10:43:34 -0400
To: Heiko Gerstung <heiko.gerstung@meinberg.de>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Backport of a 2.6.x USB driver to 2.4.32 - help needed
Message-ID: <20060606144334.GA7859@csclub.uwaterloo.ca>
References: <44854F74.50406@meinberg.de> <9a8748490606060423t102384f4m626b4366898ce9cd@mail.gmail.com> <448569CE.1020906@meinberg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <448569CE.1020906@meinberg.de>
User-Agent: Mutt/1.5.9i
From: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lsorense@csclub.uwaterloo.ca
X-SA-Exim-Scanned: No (on caffeine.csclub.uwaterloo.ca); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2006 at 01:41:02PM +0200, Heiko Gerstung wrote:
> Yes, but unfortunately I have no chance to do this and therefore I rely
> on others to do this. Well, the same applies to [me] and [kernel
> drivers], but I hoped that it might be easier to try and backport one
> driver instead of trying to improve other people's code (maybe that is
> what OPC stands for :-)), especially when this code has a much larger
> impact on several parts of the kernel.

Which part of PPS doesn't work on 2.6 if you have the PPS-kit-light
installed?  There is a version for 2.6.15 around, which applies to
2.6.16 with minimal fixing.  Only problem I found so far with the code
was that it breaks the serial console on my system, but that was easy to
fix.  I still have to test it though since my serial port has the CD
line stuck high at the moment until I can get the board fixed, so
testing is a bit tricky.

I know I have run a gps receiver with PPS on the CD line under 2.6.8
using PPS-kit-light, and it worked rather well.

Len Sorensen
