Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262118AbTK1Kdy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 05:33:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262126AbTK1Kdy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 05:33:54 -0500
Received: from ns.suse.de ([195.135.220.2]:20696 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262118AbTK1Kdw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 05:33:52 -0500
To: Raj <raju@mailandnews.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Strange behavior observed w.r.t 'su' command
References: <3FC707B6.1070704@mailandnews.com>
From: Andreas Schwab <schwab@suse.de>
X-Yow: I'm pretending I'm pulling in a TROUT!  Am I doing it correctly??
Date: Fri, 28 Nov 2003 11:33:48 +0100
In-Reply-To: <3FC707B6.1070704@mailandnews.com> (Raj's message of "Fri, 28
 Nov 2003 14:00:46 +0530")
Message-ID: <jeoeuw7pf7.fsf@sykes.suse.de>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Raj <raju@mailandnews.com> writes:

> hi, i am not sure if this is a kernel problem or an 'su' related issue,
> but this is what  i have observed. Tried on 2.4.20-8 ( RH 9.0 kernel ) and
> latest 2.6.0-test11.
>
> - log in as any normal user. ( on Console.).
> - su - root
> - from root prompt, run 'ps' and check the pid of 'su'.
> - kill -9 <pid of su>
> After the kill command, strangely my keyboard switches to unbuffered mode
> ( a key press is processed immediately ). Also, i alternate between the
> root prompt and the normal user prompt.
> Every key press switches from root prompt to normal user prompt and vice
> versa. Typing 'whoami' at the respective prompts displays 'normal user'
> and 'root' for the respective prompts.

Nothing unusual, you just have two shells competing with each other on the
terminal.  Don't use kill -9 unless you know what you are doing.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Deutschherrnstr. 15-19, D-90429 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
