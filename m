Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272259AbTHRS5R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 14:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272265AbTHRS5R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 14:57:17 -0400
Received: from serenity.mcc.ac.uk ([130.88.200.93]:23557 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP id S272259AbTHRS5J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 14:57:09 -0400
Date: Mon, 18 Aug 2003 19:57:02 +0100
From: John Levon <levon@movementarian.org>
To: Andries.Brouwer@cwi.nl
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: Maximum x86 swap partition size ?
Message-ID: <20030818185702.GA89322@compsoc.man.ac.uk>
References: <UTC200308181839.h7IIdSG10173.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <UTC200308181839.h7IIdSG10173.aeb@smtp.cwi.nl>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: King of Woolworths - L'Illustration Musicale
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19opBg-0003Yg-Qe*oI7lUNXXKP6*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 18, 2003 at 08:39:28PM +0200, Andries.Brouwer@cwi.nl wrote:

> A careful answer requires inspection of the development of
> the code involved. Let me give a rough answer from memory,
> clarifying why mkswap contains severe restrictions.

Thanks for the clarification.

> The strange limitations documented in mkswap(8) are true limitations
> for certain oldish kernels. If the assumption is that nobody uses
> 2.2 anymore then these can be removed. But lots of people still use 2.2.

I would strongly prefer that such documentation of older restrictions be
moved to the NOTES section of mkswap(8). The set of users who :

o are using util-linux 2.12+
o are using pre-2.4 kernels
o will read the mkswap(8) man page
o will not read such a NOTES section

seems relatively small to me when compared to the number of users
confused by the text (including the admin who originally brought this
up, was under the impression the limit still applied generally due to
the man page, and has also been told so by Red Hat support).
 
regards,
john

-- 
Khendon's Law:
If the same point is made twice by the same person, the thread is over.
