Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262762AbUCJSiF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 13:38:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262769AbUCJSiF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 13:38:05 -0500
Received: from are.twiddle.net ([64.81.246.98]:52096 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id S262762AbUCJSiA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 13:38:00 -0500
Date: Wed, 10 Mar 2004 10:37:55 -0800
From: Richard Henderson <rth@twiddle.net>
To: Andrew Haley <aph@redhat.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Thomas Schlichter <thomas.schlichter@web.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       gcc@gcc.gnu.org
Subject: Re: [PATCH] fix warning about duplicate 'const'
Message-ID: <20040310183755.GC6647@twiddle.net>
Mail-Followup-To: Andrew Haley <aph@redhat.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Thomas Schlichter <thomas.schlichter@web.de>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	gcc@gcc.gnu.org
References: <200403090043.21043.thomas.schlichter@web.de> <20040308161410.49127bdf.akpm@osdl.org> <Pine.LNX.4.58.0403081627450.9575@ppc970.osdl.org> <200403090217.40867.thomas.schlichter@web.de> <Pine.LNX.4.58.0403081728250.9575@ppc970.osdl.org> <20040310054918.GB4068@twiddle.net> <Pine.LNX.4.58.0403100740120.1092@ppc970.osdl.org> <20040310182227.GA6647@twiddle.net> <16463.24215.666911.238474@cuddles.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16463.24215.666911.238474@cuddles.cambridge.redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2004 at 06:29:43PM +0000, Andrew Haley wrote:
> Can't we dispatch such things to "-pedantic" ?  Or treat "const const"
> like "long long" used to be, a gcc extension?

Willy has just reminded me about a patch he wrote to do just this.
Looking at it.


r~
