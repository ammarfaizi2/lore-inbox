Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317472AbSHLHcN>; Mon, 12 Aug 2002 03:32:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317470AbSHLHcN>; Mon, 12 Aug 2002 03:32:13 -0400
Received: from mail.webmaster.com ([216.152.64.131]:61142 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S317469AbSHLHcK> convert rfc822-to-8bit; Mon, 12 Aug 2002 03:32:10 -0400
From: David Schwartz <davids@webmaster.com>
To: <jroland@roland.net>, <Hell.Surfers@cwctv.net>, <riel@conectiva.com.br>,
       <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 2.61 (1055) - Licensed Version
Date: Mon, 12 Aug 2002 00:35:56 -0700
In-Reply-To: <002701c241bf$54e64010$2102a8c0@gespl2k1>
Subject: Re: RE:Re: The spam problem.
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <20020812073558.AAA17330@shell.webmaster.com@whenever>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 12 Aug 2002 00:15:53 -0500, Jim Roland wrote:

>Now there's a good thought!  Post, Confirm, gets posted.  If member, no
>confirmation necessary.

	You could also put them in a manual hold queue. Give a large number of 
people ability to approve posts from that queue so latency would be 
reasonable.

	The problem with confirmation is that a person might fire off a bug report 
where they happen to be, via something like

dmesg > foo
joe foo
cat foo + mail -s "Bug report blah blah" linux-kernel@vger.kernel.org

	A confirmation sent to the source address of that might not be noticed until 
the next time they happen to log into that account on that machine.

	You could do both, I guess. A hold queue that can be manually processed with 
confirmation posting the message and removing it from the hold queue.

	DS


