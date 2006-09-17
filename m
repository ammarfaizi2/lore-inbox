Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932119AbWIQBih@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932119AbWIQBih (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 21:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932120AbWIQBih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 21:38:37 -0400
Received: from opersys.com ([64.40.108.71]:58887 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S932119AbWIQBig (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 21:38:36 -0400
Message-ID: <450CABE8.9050106@opersys.com>
Date: Sat, 16 Sep 2006 21:59:04 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060804 Fedora/1.0.4-0.5.1.fc5 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Ingo Molnar <mingo@elte.hu>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       Jes Sorensen <jes@sgi.com>, Roman Zippel <zippel@linux-m68k.org>,
       tglx@linutronix.de, Paul Mundt <lethal@linux-sh.org>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Tom Zanussi <zanussi@us.ibm.com>, ltt-dev@shafik.org,
       Michel Dagenais <michel.dagenais@polymtl.ca>, fche@redhat.com
Subject: Re: [patch] kprobes: optimize branch placement
References: <Pine.LNX.4.64.0609152111030.6761@scrub.home>	<20060915200559.GB30459@elte.hu>	<20060915202233.GA23318@Krystal>	<450BCAF1.2030205@sgi.com>	<20060916172419.GA15427@Krystal>	<20060916173552.GA7362@elte.hu>	<20060916175606.GA2837@Krystal>	<20060916191043.GA22558@elte.hu>	<20060916193745.GA29022@elte.hu>	<20060916202939.GA4520@elte.hu>	<20060916204342.GA5208@elte.hu>	<450C7039.20208@opersys.com> <20060916155704.ef425542.akpm@osdl.org>
In-Reply-To: <20060916155704.ef425542.akpm@osdl.org>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew Morton wrote:
> It's hardly rocket science - it appears that nobody has ever bothered.

Hmm, that's one explanation. The other explanation, which in my view is
the likelier -- but I've been shown wrong before, is that most of those
who went through that code before just didn't have Ingo's insight and
abilities. Which goes to show what can be achieved when "interesting"
ideas are given a hand by those having appropriate insight and
abilities -- and, of course, what fate awaits those other ideas which
are less so fortunate in the eyes of the talented. Praise the lord for
the chosen ones.

Karim
-- 
President  / Opersys Inc.
Embedded Linux Training and Expertise
www.opersys.com  /  1.866.677.4546
