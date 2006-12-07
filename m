Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1032038AbWLGLNM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032038AbWLGLNM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 06:13:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032040AbWLGLNM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 06:13:12 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:45557 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1032038AbWLGLNH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 06:13:07 -0500
Date: Thu, 7 Dec 2006 12:11:17 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Randy Dunlap <randy.dunlap@oracle.com>
cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>,
       jesper.juhl@gmail.com
Subject: Re: [PATCH/RFC] CodingStyle updates
In-Reply-To: <20061207004838.4d84842c.randy.dunlap@oracle.com>
Message-ID: <Pine.LNX.4.61.0612071206160.2863@yvahk01.tjqt.qr>
References: <20061207004838.4d84842c.randy.dunlap@oracle.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Dec 7 2006 00:48, Randy Dunlap wrote:
>+The preferred way to ease multiple indentation levels in a switch
>+statement is to align the "switch" and its subordinate "case" labels in
>+the same column instead of "double-indenting" the "case" labels.  E.g.:
>+
>+	switch (suffix) {
>+	case 'G':
>+	case 'g':
>+		mem <<= 10;
>+	case 'M':
>+	case 'm':
>+		mem << 10;
                ^^^^^^^^^^

Statement has no effect ;-)

>+	case 'K':
>+	case 'k':
>+		mem << 10;

Make that <<=.

>+Use one space around (on each side of) most binary operators, such as
>+any of these:
>+		=  +  -  <  >  *  /  %  |  &  ^  <=  >=  ==  !=

And the ternary operator ?:

>+but no space after unary operators:
>+		sizeof  ++  --  &  *  +  -  ~  !  defined

And no space before these unary operators,
++ (postincrement) -- (postdecrement)

What keyword is "defined"? Did you have too much Perl coffee? :)

>+and no space around the '.' unary operator.

Same goes for ->


>+Linux style for comments is the pre-C99 "/* ... */" style.

Aka C89.

>+Don't use C99-style "// ..." comments.
>+
>+The preferred style for long (multi-line) comments is:
>+
>+	/*
>+	 * This is the preferred style for multi-line
>+	 * comments in the Linux kernel source code.
>+	 * Please use it consistently.
>+	 */

Description: Stars to the left with two almost blank (/*, */) lines.



	-`J'
-- 
