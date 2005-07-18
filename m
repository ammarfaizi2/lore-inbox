Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261781AbVGRPVF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261781AbVGRPVF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 11:21:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261785AbVGRPVF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 11:21:05 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:63625 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261781AbVGRPVD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 11:21:03 -0400
Date: Mon, 18 Jul 2005 17:20:40 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Karim Yaghmour <karim@opersys.com>
cc: Steven Rostedt <rostedt@goodmis.org>, Tom Zanussi <zanussi@us.ibm.com>,
       richardj_moore@uk.ibm.com, varap@us.ibm.com,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Merging relayfs?
In-Reply-To: <42DBBD69.3030300@opersys.com>
Message-ID: <Pine.LNX.4.61.0507181706430.3728@scrub.home>
References: <17107.6290.734560.231978@tut.ibm.com>  <20050712022537.GA26128@infradead.org>
  <20050711193409.043ecb14.akpm@osdl.org>  <Pine.LNX.4.61.0507131809120.3743@scrub.home>
  <17110.32325.532858.79690@tut.ibm.com>  <Pine.LNX.4.61.0507171551390.3728@scrub.home>
  <17114.32450.420164.971783@tut.ibm.com> <1121694275.12862.23.camel@localhost.localdomain>
 <Pine.LNX.4.61.0507181607410.3743@scrub.home> <42DBBD69.3030300@opersys.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 18 Jul 2005, Karim Yaghmour wrote:

> I guess I just don't get the point here. Why cut something away if many
> users will need it. If it's that popular that you're ready to provide a
> library function to do it, then why not just leave it to boot? One of the
> goals of relayfs is to avoid code duplication with regards to buffering
> in general.

The road to bloatness is paved with lots of little features.
There aren't that many users anyway (none of the examples use that 
feature). I'd prefer to concentrate on a simple and correct relayfs layer 
and we can still think about other features as more users appear.
Starting a design by implementing every little feature which _might_ be 
needed is a really bad idea.

bye, Roman
