Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262100AbTFIVWL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 17:22:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262116AbTFIVWK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 17:22:10 -0400
Received: from mail.webmaster.com ([216.152.64.131]:46271 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP id S262100AbTFIVVx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 17:21:53 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Davide Libenzi" <davidel@xmailserver.org>
Cc: "Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: Coding standards.  (Was: Re: [PATCH] [2.5] Non-blocking write can block)
Date: Mon, 9 Jun 2003 14:35:31 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKCELPDIAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <Pine.LNX.4.55.0306091142420.3614@bigblue.dev.mcafeelabs.com>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> If you try to define a bad/horrible "whatever" in an *absolute* way you
> need either the *absolutely* unanimous consent or you need to prove it
> using a logical combination of already proven absolute concepts. Since you
> missing both of these requirements you cannot say that something is
> bad/wrong in an absolute way. You can say though that something is
> wrong/bad when dropped inside a given context, and a coding standard might
> work as an example. If you try to approach a developer by saying that he
> has to use ABC coding standard because it is better that his XYZ coding
> standard you're just wrong and you'll have hard time to have him to
> understand why he has to use the suggested standard when coding inside the
> project JKL. The coding standard gives you the *rule* to define something
> wrong when seen inside a given context, since your personal judgement does
> not really matter here.
>
> - Davide

	This is just bad philosophy. You might as well argue that a canvas that's
been randomly pissed on is just as much art as the Mona Lisa. In fact, it's
a worse argument than that because coding styles aim at objective,
measurable goals. Why does consent matter? If some imbecile wants to argue
that it's good to write code that's hard to understand and debug, why should
we care what he has to say? The consent of people whose opinions are
nonsensical is of no value to people who are trying to create rules that
meet their objective requirements.

	Coding styles aim at specific measurable goals. Code should be easy to
understand, extend, and debug. If someone argues code should be hard to
understand, maintain, and debug, we just ignore him. We don't care if he
agrees with us or not because his opinion is obviously (and objectively) of
no value.

	We can measure, for different coding style, how long it takes to find a
bug. We can measure how long it takes a new programmer to get to the point
that he can contribute to the existing code.

	Coding styles are engineering rules. We can validate them based upon the
results they produce. Objective, measureable results.

	DS


