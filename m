Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263367AbTJZSAJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 13:00:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263369AbTJZSAJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 13:00:09 -0500
Received: from main.gmane.org ([80.91.224.249]:1952 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263367AbTJZSAG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 13:00:06 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: Alsa deadlock fix
Date: Sun, 26 Oct 2003 19:00:01 +0100
Message-ID: <yw1xbrs3g9r2.fsf@kth.se>
References: <200310261145.18537.puetzk@puetzk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:ISB0M3JgAXuwuLvlhIWPni9/Sm8=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin Puetz <puetzk@puetzk.org> writes:

> But a deadlock that results in two unkillable state 'D' processes
> whenever you an OSS and an alsa-native app access the soundcard at
> the same time, which happens on both VIA and Intel integrated sound,
> seems like a hang which might meet his criteria of problems which
> "causes lockups or just basic nonworkingness: and this happens on
> hardware that normal people are expected to have". So I figured it's
> worth asking if someone who already knows what the fix consisted of
> could push it toward Linus ...

It's fixed in -test9.

-- 
Måns Rullgård
mru@kth.se

