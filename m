Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262129AbTK1LLo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 06:11:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262131AbTK1LLo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 06:11:44 -0500
Received: from main.gmane.org ([80.91.224.249]:30887 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262129AbTK1LLn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 06:11:43 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: Strange behavior observed w.r.t 'su' command
Date: Fri, 28 Nov 2003 12:11:40 +0100
Message-ID: <yw1xy8u021eb.fsf@kth.se>
References: <3FC707B6.1070704@mailandnews.com> <jeoeuw7pf7.fsf@sykes.suse.de>
 <yw1x65h43h3b.fsf@kth.se> <je3cc87oic.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:W1jv0+2lhWfvLN8HLhnYtbosW1w=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Schwab <schwab@suse.de> writes:

>> It appears that my su exec()s the shell, whereas the redhat and gentoo
>> su fork() and exec().
>
> Yes, your su probably does not support PAM.

I don't think it does.  I still don't see the need to fork when using
PAM.

-- 
Måns Rullgård
mru@kth.se

