Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262253AbTFIWnu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 18:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262256AbTFIWnu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 18:43:50 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:24205 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S262253AbTFIWnr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 18:43:47 -0400
X-AuthUser: davidel@xmailserver.org
Date: Mon, 9 Jun 2003 15:55:23 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: David Schwartz <davids@webmaster.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: Coding standards.  (Was: Re: [PATCH] [2.5] Non-blocking write
 can block)
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKCELPDIAA.davids@webmaster.com>
Message-ID: <Pine.LNX.4.55.0306091438170.3614@bigblue.dev.mcafeelabs.com>
References: <MDEHLPKNGKAHNMBLJOLKCELPDIAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Jun 2003, David Schwartz wrote:

> 	This is just bad philosophy.

Actually, that's logic/mathematics. Philosophy is on the other side. We
can say that mathematic/logic compare to philosophy like facts to bullshits.


> been randomly pissed on is just as much art as the Mona Lisa. In fact, it's
> a worse argument than that because coding styles aim at objective,
> measurable goals. Why does consent matter? If some imbecile wants to argue
> that it's good to write code that's hard to understand and debug, why should
> we care what he has to say? The consent of people whose opinions are
> nonsensical is of no value to people who are trying to create rules that
> meet their objective requirements.

A coding style is a very personal thing, you cannot say that the XYZ's
coding style is wrong. Period. Is like saying that your taste for cars is
wrong because you picked up an ABC against a JKL. If you say that XYZ's
coding style is wrong, without dropping it inside a specific context
(like an environment ruled by a coding standard for example), you
are trying to give an absolute judgement of it. Absolute judgements need
either absolutely unanimous consent or they need to be proven using a set
of already proven absolute concepts. You can say that *for you* (for-you
== relative) this is right :

	if (a == b) {
		...
	}

while this is wrong :

	if( a == b )
	{
		...
	}

I might agree with you, that makes two. But there will be for sure someone
that will personally prefer the latter. And this will break the unanimous
consent. Are you able to prove using a set of already proven absolute
concepts that the former is right and the latter is wrong ? The only way
that you have to say that something personal like a coding style is
"wrong" is through a set of rules like a coding standard document. So, to
close the circle, a coding standard document (like the one we have) more
than your very personal judgement, enable you to say that some code is
wrong. If you fail to understand this you will have hard times to
gracefully convince your developers why it is good to use the dictated
coding standard inside professional projects. The "your style sux" is not
generally well accepted by persons with serious attitude problems like
developers.



- Davide

