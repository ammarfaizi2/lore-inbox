Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266162AbUBQN6c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 08:58:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266172AbUBQN6c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 08:58:32 -0500
Received: from rogue.ncsl.nist.gov ([129.6.101.41]:60848 "EHLO
	rogue.ncsl.nist.gov") by vger.kernel.org with ESMTP id S266162AbUBQN6b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 08:58:31 -0500
To: Dave Kleikamp <shaggy@austin.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0, BUG() in JFS
References: <9cf1xozw09t.fsf@rogue.ncsl.nist.gov>
	<1076950722.4534.19.camel@shaggy.austin.ibm.com>
From: Ian Soboroff <ian.soboroff@nist.gov>
Date: Tue, 17 Feb 2004 08:57:21 -0500
In-Reply-To: <1076950722.4534.19.camel@shaggy.austin.ibm.com> (Dave
 Kleikamp's message of "Mon, 16 Feb 2004 10:58:42 -0600")
Message-ID: <9cfbrnx4xmm.fsf@rogue.ncsl.nist.gov>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Kleikamp <shaggy@austin.ibm.com> writes:

> On Fri, 2004-02-13 at 07:56, Ian Soboroff wrote:
>> I got this oops this morning.  This machine is running 2.6.0... is
>> this something that's been fixed already?
>
> I've seen this reported before, but not with any regularity.  Either a
> directory is somehow corrupted, or the directory grew beyond what JFS
> was designed to handle (which shouldn't really happen).  Do you have any
> directories that would have tens of thousands of entries or more?
>
> What is the result of running fsck?

fsck reported some errors, but since there were outstanding processes
stuck in the 'D' state, I wanted to wait for the chance to reboot
before letting it repair them.

Ian


