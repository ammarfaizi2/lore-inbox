Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262078AbTK1JP4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 04:15:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262086AbTK1JP4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 04:15:56 -0500
Received: from main.gmane.org ([80.91.224.249]:30886 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262078AbTK1JPy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 04:15:54 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: Strange behavior observed w.r.t 'su' command
Date: Fri, 28 Nov 2003 10:15:50 +0100
Message-ID: <yw1xekvs3lbt.fsf@kth.se>
References: <3FC707B6.1070704@mailandnews.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:kTVIaU7m61Z1aR87nSsjEzLFz8Y=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Raj <raju@mailandnews.com> writes:

> hi, i am not sure if this is a kernel problem or an 'su' related
> issue, but this is what  i have observed. Tried on 2.4.20-8 ( RH 9.0
> kernel ) and latest 2.6.0-test11.
>
> - log in as any normal user. ( on Console.).
> - su - root
> - from root prompt, run 'ps' and check the pid of 'su'.
> - kill -9 <pid of su>
> After the kill command, strangely my keyboard switches to unbuffered
> mode ( a key press is processed immediately ). Also, i alternate
> between the root prompt and the normal user prompt.
> Every key press switches from root prompt to normal user prompt and
> vice versa. Typing 'whoami' at the respective prompts displays 'normal
> user' and 'root' for the respective prompts.

I can't reproduce it on Slackware running 2.6.0-test10.  It's probably
a redhat thing.

-- 
Måns Rullgård
mru@kth.se

