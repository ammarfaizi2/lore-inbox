Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262126AbTK1LC2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 06:02:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262127AbTK1LC2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 06:02:28 -0500
Received: from ns.suse.de ([195.135.220.2]:57570 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262126AbTK1LC1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 06:02:27 -0500
To: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Cc: linux-kernel@vger.kernel.org
Subject: Re: Strange behavior observed w.r.t 'su' command
References: <3FC707B6.1070704@mailandnews.com> <jeoeuw7pf7.fsf@sykes.suse.de>
	<yw1x65h43h3b.fsf@kth.se>
From: Andreas Schwab <schwab@suse.de>
X-Yow: I like the IMPUDENT NOSE on that car..  Are you a TEEN-AGER?  
Date: Fri, 28 Nov 2003 11:53:31 +0100
In-Reply-To: <yw1x65h43h3b.fsf@kth.se> (
 =?iso-8859-1?q?M=E5ns_Rullg=E5rd's_message_of?= "Fri, 28 Nov 2003 11:47:20
 +0100")
Message-ID: <je3cc87oic.fsf@sykes.suse.de>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mru@kth.se (Måns Rullgård) writes:

> It appears that my su exec()s the shell, whereas the redhat and gentoo
> su fork() and exec().

Yes, your su probably does not support PAM.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Deutschherrnstr. 15-19, D-90429 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
