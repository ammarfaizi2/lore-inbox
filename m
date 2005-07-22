Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262228AbVGVX1W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262228AbVGVX1W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 19:27:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262229AbVGVX1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 19:27:13 -0400
Received: from opersys.com ([64.40.108.71]:14864 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S262228AbVGVXZh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 19:25:37 -0400
Message-ID: <42E17EEC.5070102@opersys.com>
Date: Fri, 22 Jul 2005 19:19:08 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Tom Zanussi <zanussi@us.ibm.com>
CC: Roman Zippel <zippel@linux-m68k.org>, Steven Rostedt <rostedt@goodmis.org>,
       richardj_moore@uk.ibm.com, varap@us.ibm.com,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Merging relayfs?
References: <17107.6290.734560.231978@tut.ibm.com>	<20050712022537.GA26128@infradead.org>	<20050711193409.043ecb14.akpm@osdl.org>	<Pine.LNX.4.61.0507131809120.3743@scrub.home>	<17110.32325.532858.79690@tut.ibm.com>	<Pine.LNX.4.61.0507171551390.3728@scrub.home>	<17114.32450.420164.971783@tut.ibm.com>	<1121694275.12862.23.camel@localhost.localdomain>	<Pine.LNX.4.61.0507181607410.3743@scrub.home>	<42DBBD69.3030300@opersys.com>	<Pine.LNX.4.61.0507181706430.3728@scrub.home>	<17115.53671.326542.392470@tut.ibm.com> <17121.23125.981162.389667@tut.ibm.com>
In-Reply-To: <17121.23125.981162.389667@tut.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Tom Zanussi wrote:
> - removed the deliver() callback
> - removed the relay_commit() function

This breaks LTT. Any reason why this needed to be removed? In the end,
the code will just end up being duplicated in ltt and all other users.
IOW, this is not some potential future use, but something that's
currently being used.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
