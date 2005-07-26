Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262245AbVGZXcx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262245AbVGZXcx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 19:32:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261256AbVGZXaH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 19:30:07 -0400
Received: from twinlark.arctic.org ([207.7.145.18]:33973 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP id S262341AbVGZX2T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 19:28:19 -0400
Date: Tue, 26 Jul 2005 16:28:16 -0700 (PDT)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Marc Ballarin <Ballarin.Marc@gmx.de>
cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: Power consumption HZ250 vs. HZ1000
In-Reply-To: <20050725210253.61d2da13.Ballarin.Marc@gmx.de>
Message-ID: <Pine.LNX.4.63.0507261626470.16638@twinlark.arctic.org>
References: <20050725161333.446fe265.Ballarin.Marc@gmx.de>
 <20050725155322.GA1046@openzaurus.ucw.cz> <20050725210253.61d2da13.Ballarin.Marc@gmx.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jul 2005, Marc Ballarin wrote:

> Hmm, just did. I even tried the rather minimalistic configuration below.
> Still no C3. (And what seems even stranger: no C1.)

there's no point to going into C1 if the C2 entry/exit latencies are 
acceptable.  (winxp generally never uses C1 if C2 is available and within 
the specs msft dictates for C2 latencies...)

-dean
