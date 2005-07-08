Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262652AbVGHNJa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262652AbVGHNJa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 09:09:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262651AbVGHNJ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 09:09:29 -0400
Received: from opersys.com ([64.40.108.71]:11026 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S262652AbVGHNJX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 09:09:23 -0400
Message-ID: <42CE7D89.7030303@opersys.com>
Date: Fri, 08 Jul 2005 09:20:09 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>, LTT-Dev <ltt-dev@shafik.org>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Robert Wisniewski <bob@watson.ibm.com>,
       Mathieu Desnoyers <compudj@krystal.dyndns.org>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Michael Raymond <mraymond@sgi.com>
Subject: Re: [PATCH/RFC] Significantly reworked LTT core
References: <42C60001.5050609@opersys.com> <20050702160445.GA29262@infradead.org> <42C703E4.2060202@opersys.com> <20050707141125.GA31025@infradead.org>
In-Reply-To: <20050707141125.GA31025@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Christoph Hellwig wrote:
> We're not gonna add hooks to the kernel so you can copile the same
> horrible code you had before against it out of tree.  Do a sane demux
> and submit it.

If I just wanted hooks, I would have submitted a patch that did just
that, without any logging function. The code for the mux that goes
on top of that code is actually on its way to be completely rewritten.
I can see that you may have read my posting as indicating that we were
recompiling the same previous code out of tree, but that is certainly
not the intent.

FWIW, we'll look submitting a minimal mux with the patch.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
