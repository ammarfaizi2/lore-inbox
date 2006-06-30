Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751342AbWF3Wbj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342AbWF3Wbj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 18:31:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751371AbWF3Wbj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 18:31:39 -0400
Received: from sj-iport-1-in.cisco.com ([171.71.176.70]:28839 "EHLO
	sj-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1751342AbWF3Wbi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 18:31:38 -0400
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC: unlazy fpu for frequent fpu users
X-Message-Flag: Warning: May contain useful information
References: <1151705536.11434.69.camel@laptopd505.fenrus.org>
From: Roland Dreier <rdreier@cisco.com>
Date: Fri, 30 Jun 2006 15:31:36 -0700
In-Reply-To: <1151705536.11434.69.camel@laptopd505.fenrus.org> (Arjan van de Ven's message of "Sat, 01 Jul 2006 00:12:16 +0200")
Message-ID: <ada7j2ye0mv.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 30 Jun 2006 22:31:37.0713 (UTC) FILETIME=[F3453610:01C69C94]
Authentication-Results: sj-dkim-2.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > +	/* prefetch the fxsave area into the cache */
 > +	prefetch(&next->i387.fxsave);

This chunk is not obviously related to the rest of the patch, and
perhaps needs additional justification.

And the comment getting pretty close to

	/* set i to 2 */
	i = 2;

territory ;)

 - R.
