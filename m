Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965176AbWIRAmd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965176AbWIRAmd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 20:42:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965178AbWIRAmc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 20:42:32 -0400
Received: from opersys.com ([64.40.108.71]:57359 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S965176AbWIRAmb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 20:42:31 -0400
Message-ID: <450DF05E.50807@opersys.com>
Date: Sun, 17 Sep 2006 21:03:26 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060804 Fedora/1.0.4-0.5.1.fc5 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Paul Mundt <lethal@linux-sh.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Ingo Molnar <mingo@redhat.com>, Jes Sorensen <jes@sgi.com>,
       Andrew Morton <akpm@osdl.org>, Roman Zippel <zippel@linux-m68k.org>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       "Frank Ch. Eigler" <fche@redhat.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>
Subject: Re: The emperor is naked: why *comprehensive* static markup belongs
 in mainline
References: <450D182B.9060300@opersys.com> <20060917112128.GA3170@localhost.usen.ad.jp>
In-Reply-To: <20060917112128.GA3170@localhost.usen.ad.jp>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Paul Mundt wrote:
> The only issue with this is that the argument list has to be maintained
> in two places.

Not necessarily. LTTng's genevent stuff could be intelligently used here.
Ideally markup is self-contained: it provides code location and context,
and provides any additional information required for postmortem
"rendering" of the event (i.e. how the event is displayed/analyzed).

Karim
-- 
President  / Opersys Inc.
Embedded Linux Training and Expertise
www.opersys.com  /  1.866.677.4546
