Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263747AbTJ0EAT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 23:00:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263753AbTJ0EAT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 23:00:19 -0500
Received: from main.gmane.org ([80.91.224.249]:30115 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263747AbTJ0EAQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 23:00:16 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Kevin Puetz <puetzk@puetzk.org>
Subject: Re: Alsa deadlock fix
Date: Sun, 26 Oct 2003 22:00:11 -0600
Message-ID: <bni58b$hbt$1@sea.gmane.org>
References: <200310261145.18537.puetzk@puetzk.org> <yw1xbrs3g9r2.fsf@kth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: KNode/0.7.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Måns Rullgård wrote:

> Kevin Puetz <puetzk@puetzk.org> writes:
> 
>> But a deadlock that results in two unkillable state 'D' processes
>> whenever you an OSS and an alsa-native app access the soundcard at
>> the same time, which happens on both VIA and Intel integrated sound,
>> seems like a hang which might meet his criteria of problems which
>> "causes lockups or just basic nonworkingness: and this happens on
>> hardware that normal people are expected to have". So I figured it's
>> worth asking if someone who already knows what the fix consisted of
>> could push it toward Linus ...
> 
> It's fixed in -test9.
> 
Thanks, sorry about the bogus report then. I looked at the -test8 -> -test9
changes before I sent it, but missed it since it was from akpm (not
jaroslav) and didn't mention alsa in the changelog message. Thus it missed
both categories I thought to search for in the applied changes :-P

