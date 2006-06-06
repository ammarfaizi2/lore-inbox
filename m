Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932197AbWFFOs4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932197AbWFFOs4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 10:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932194AbWFFOs4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 10:48:56 -0400
Received: from server1.meinberg.de ([85.10.202.66]:18613 "EHLO
	paolo.meinberg.de") by vger.kernel.org with ESMTP id S932197AbWFFOs4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 10:48:56 -0400
Message-ID: <448595CC.8040607@meinberg.de>
Date: Tue, 06 Jun 2006 16:48:44 +0200
From: Heiko Gerstung <heiko.gerstung@meinberg.de>
Organization: Meinberg Radio Clocks
User-Agent: Thunderbird 1.5.0.2 (X11/20060601)
MIME-Version: 1.0
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
CC: Jesper Juhl <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Backport of a 2.6.x USB driver to 2.4.32 - help needed
References: <44854F74.50406@meinberg.de> <9a8748490606060423t102384f4m626b4366898ce9cd@mail.gmail.com> <448569CE.1020906@meinberg.de> <20060606144334.GA7859@csclub.uwaterloo.ca>
In-Reply-To: <20060606144334.GA7859@csclub.uwaterloo.ca>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Lennart:

Lennart Sorensen wrote:
> On Tue, Jun 06, 2006 at 01:41:02PM +0200, Heiko Gerstung wrote:
>> Yes, but unfortunately I have no chance to do this and therefore I rely
>> on others to do this. Well, the same applies to [me] and [kernel
>> drivers], but I hoped that it might be easier to try and backport one
>> driver instead of trying to improve other people's code (maybe that is
>> what OPC stands for :-)), especially when this code has a much larger
>> impact on several parts of the kernel.
> 
> Which part of PPS doesn't work on 2.6 if you have the PPS-kit-light
> installed?  There is a version for 2.6.15 around, which applies to
> 2.6.16 with minimal fixing.  Only problem I found so far with the code
> was that it breaks the serial console on my system, but that was easy to
> fix.  I still have to test it though since my serial port has the CD
> line stuck high at the moment until I can get the board fixed, so
> testing is a bit tricky.
> 
> I know I have run a gps receiver with PPS on the CD line under 2.6.8
> using PPS-kit-light, and it worked rather well.

It works but on my system it takes ~4 hours before I reach lower
microsecond offsets, where the 2.4 ppskit is below 10 microseconds after
four polling cycles. I already tried to fix that but the internal kernel
pps discipline is not working as good as  it did with the 2.4 ppskit
versions.

> 
> Len Sorensen

Kind regards,
Heiko



-- 
------------------------------------------------------------------------

*MEINBERG Funkuhren GmbH & Co. KG*
Auf der Landwehr 22
D-31812 Bad Pyrmont, Germany
Tel.: ++49 (0)5281 9309-25
Fax: ++49 (0)5281 9309-30
eMail: heiko.gerstung@meinberg.de <mailto:heiko.gerstung@meinberg.de>
Internet: www.meinberg.de <http://www.meinberg.de/>

------------------------------------------------------------------------

Meinberg radio clocks: 25 years of accurate time worldwide

