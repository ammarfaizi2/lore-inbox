Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264656AbUGHP4r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264656AbUGHP4r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 11:56:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264627AbUGHP4q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 11:56:46 -0400
Received: from cantor.suse.de ([195.135.220.2]:37774 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264697AbUGHP4h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 11:56:37 -0400
To: Michael Poole <mdpoole@troilus.org>
Cc: root@chaos.analogic.com, "P. Benie" <pjb1008@eng.cam.ac.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use NULL instead of integer 0 in security/selinux/
References: <E1BiPKz-0008Q7-00@gondolin.me.apana.org.au>
	<E1BiPKz-0008Q7-00@gondolin.me.apana.org.au>
	<Pine.LNX.4.53.0407080707010.21439@chaos>
	<Pine.HPX.4.58L.0407081224460.28859@punch.eng.cam.ac.uk>
	<Pine.LNX.4.53.0407081030320.21855@chaos>
	<87hdsih7d9.fsf@sanosuke.troilus.org>
From: Andreas Schwab <schwab@suse.de>
X-Yow: I'm in direct contact with many advanced fun CONCEPTS.
Date: Thu, 08 Jul 2004 17:55:20 +0200
In-Reply-To: <87hdsih7d9.fsf@sanosuke.troilus.org> (Michael Poole's message
 of "Thu, 08 Jul 2004 11:00:02 -0400")
Message-ID: <je3c42trx3.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Poole <mdpoole@troilus.org> writes:

> Could you please elaborate the rules of English in which "An integer
> constant expresion with the value 0 [...] is called a null pointer
> constant" does not mean that 0 is a null pointer?

Null pointer != null pointer constant.  The latter is rather a syntactical
construct without a real value.  The process of converting a null pointer
constant to a null pointer is the point where the decision is made about
the final value and type.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
