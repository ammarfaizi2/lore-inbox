Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751814AbWJMTBk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751814AbWJMTBk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 15:01:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751815AbWJMTBk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 15:01:40 -0400
Received: from smtp.osdl.org ([65.172.181.4]:7854 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751814AbWJMTBj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 15:01:39 -0400
Date: Fri, 13 Oct 2006 12:01:29 -0700
From: Andrew Morton <akpm@osdl.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-kernel@vger.kernel.org, ak@suse.de, Don Mullis <dwm@meer.net>
Subject: Re: [patch 1/7] documentation and scripts
Message-Id: <20061013120129.76e23366.akpm@osdl.org>
In-Reply-To: <20061013174724.GB29079@localhost>
References: <20061012074305.047696736@gmail.com>
	<452df215.7ab6aae9.17a4.58b5@mx.google.com>
	<20061012143713.3f6030c8.akpm@osdl.org>
	<20061013174724.GB29079@localhost>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Oct 2006 02:47:24 +0900
Akinobu Mita <akinobu.mita@gmail.com> wrote:

> On Thu, Oct 12, 2006 at 02:37:13PM -0700, Andrew Morton wrote:
> 
> > So I wonder if it'd be better to make this have units of "one millionth",
> > or simply make this tunable "1/(probability of failure)".  So setting it to
> > 1,000,000 gives you one failure per million calls, on average.
> 
> /debug/*/interval is available for this purpose.
> The combination of below commands gives one failure per million calls.
> 
> # echo 1000000 > /debug/failslab/interval
> # echo 100 > /debug/failslab/probability

Oh.  What are the units of "interval"?

(I find it's nice to put the units in the actual filename if practical -
it's self-documenting)
