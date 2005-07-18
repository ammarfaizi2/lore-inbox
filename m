Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261774AbVGROkf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261774AbVGROkf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 10:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261785AbVGROke
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 10:40:34 -0400
Received: from opersys.com ([64.40.108.71]:21266 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261774AbVGROjJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 10:39:09 -0400
Message-ID: <42DBBD69.3030300@opersys.com>
Date: Mon, 18 Jul 2005 10:32:09 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: Steven Rostedt <rostedt@goodmis.org>, Tom Zanussi <zanussi@us.ibm.com>,
       richardj_moore@uk.ibm.com, varap@us.ibm.com,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Merging relayfs?
References: <17107.6290.734560.231978@tut.ibm.com>  <20050712022537.GA26128@infradead.org>  <20050711193409.043ecb14.akpm@osdl.org>  <Pine.LNX.4.61.0507131809120.3743@scrub.home>  <17110.32325.532858.79690@tut.ibm.com>  <Pine.LNX.4.61.0507171551390.3728@scrub.home>  <17114.32450.420164.971783@tut.ibm.com> <1121694275.12862.23.camel@localhost.localdomain> <Pine.LNX.4.61.0507181607410.3743@scrub.home>
In-Reply-To: <Pine.LNX.4.61.0507181607410.3743@scrub.home>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Roman Zippel wrote:
> The point is to design a simple and flexible relayfs layer, which means 
> not every possible function has to be done in the relayfs layer, as long 
> it's flexible enough to build additional functionality on top of it (for 
> which it can again provide some library functions).

I guess I just don't get the point here. Why cut something away if many
users will need it. If it's that popular that you're ready to provide a
library function to do it, then why not just leave it to boot? One of the
goals of relayfs is to avoid code duplication with regards to buffering
in general.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
