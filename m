Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267925AbTBELln>; Wed, 5 Feb 2003 06:41:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267926AbTBELln>; Wed, 5 Feb 2003 06:41:43 -0500
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:8206 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S267925AbTBELln>; Wed, 5 Feb 2003 06:41:43 -0500
Message-Id: <200302051143.h15BhGs18013@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Andreas Schwab <schwab@suse.de>
Subject: Re: gcc 2.95 vs 3.21 performance
Date: Wed, 5 Feb 2003 13:41:34 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
References: <200302042011.h14KBuG6002791@darkstar.example.net> <200302050717.h157HTs16569@Port.imtp.ilyichevsk.odessa.ua> <jevfzzj9ov.fsf@sykes.suse.de>
In-Reply-To: <jevfzzj9ov.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5 February 2003 12:36, Andreas Schwab wrote:
> Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> writes:
> |> I am damn sure that if you compile with less sadistic alignment
> |> you will get smaller *and* faster kernel.
>
> So why don't you try it out?  GCC offers everything you need for this
> experiment.

I did. Others did it too on occasion.

My argument was against overusing optimization techniques.
You cannot speed up kernel by aligning *everything* to 32 bytes,
or by unrolling all loops, or by aggressive inlining.
That's too easy to work. You get kernel which is bigger
*and* slower.
--
vda
