Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261766AbVGLCWk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261766AbVGLCWk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 22:22:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261771AbVGLCWk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 22:22:40 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:42217 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261766AbVGLCWj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 22:22:39 -0400
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17107.10600.661157.164699@tut.ibm.com>
Date: Mon, 11 Jul 2005 21:22:32 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: Tom Zanussi <zanussi@us.ibm.com>, linux-kernel@vger.kernel.org,
       karim@opersys.com, varap@us.ibm.com, richardj_moore@uk.ibm.com,
       rostedt@goodmis.org, baruch@ev-en.org, prasadav@us.ibm.com
Subject: Re: Merging relayfs?
In-Reply-To: <20050711184558.6346e77c.akpm@osdl.org>
References: <17107.6290.734560.231978@tut.ibm.com>
	<20050711184558.6346e77c.akpm@osdl.org>
X-Mailer: VM 7.19 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:
 > Tom Zanussi <zanussi@us.ibm.com> wrote:
 > >
 > > Hi Andrew, can you please merge relayfs?
 > 
 > I guess so.  Would you have time to prepare a list of existing and planned
 > applications?

Sure.  I know that systemtap (http://sourceware.org/systemtap/) is
using relayfs and that LTT (http://www.opersys.com/ltt/index.html) is
also currently being reworked to use it.

I've also added a couple of people to the cc: list that I've consulted
with in getting their applications to use relayfs, one of which is the
logdev debugging device recently posted to LKML.

I also know that there are still users of the old relayfs around; I
don't however know what their plans are regarding moving to the new
relayfs.

My own personal interest is to start playing around with creating some
visualization tools using data gathered from relayfs.  Hopefully, I'll
have more time to do that if relayfs gets merged. ;-)

Hope that helps,

Tom


