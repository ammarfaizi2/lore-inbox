Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964951AbWIKQAG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964951AbWIKQAG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 12:00:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964950AbWIKQAG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 12:00:06 -0400
Received: from web36614.mail.mud.yahoo.com ([209.191.85.31]:55139 "HELO
	web36614.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964947AbWIKQAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 12:00:04 -0400
Message-ID: <20060911160002.78419.qmail@web36614.mail.mud.yahoo.com>
X-RocketYMMF: rancidfat
Date: Mon, 11 Sep 2006 09:00:02 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: capability inheritance (was: Re: patch to make Linux capabilities into something useful (v 0.3.1))
To: David Madore <david.madore@ens.fr>
Cc: Linux Kernel mailing-list <linux-kernel@vger.kernel.org>
In-Reply-To: <20060910142540.GA19804@clipper.ens.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- David Madore <david.madore@ens.fr> wrote:

> I can see no way of reconciling the POSIX rules with
> sane Unix behavior.

While one strives to maintain the decorum of
friendly debate, "Them's fighting words"*.

Have you read the POSIX DRAFT rationale section?
Have you read any of the DRAFT, for that matter?

Breaking privilege apart from UID==0 and the
setuid mechanism while allowing a system that
could still work without requiring programs
to be rewritten took quite a while. The DRAFT
versions don't differ that greatly after about
DRAFT 12. The scheme has been implemented
several times.

> Hence I can only give up if someone
> insists that the POSIX
> draft should be adhered to.
> 
> (Just in case someone were tempted to get away with
> a handwaving such
> as "just follow the POSIX rules except for suid
> root...", let that
> someone please try to come up with a full
> description of the rules
> which breaks nothing, and he will understand that
> it's not at all easy.)

The relationship between setuid and file based
capabilitiy sets is straitforward. There is
none. If your system supports root or capability
(like Irix) or strictly capability (like Trix)
the calculation is identical. There is a full
descrition of the rules in the DRAFT. If you
have questions about it, I'd be happy to dust
off my copy to help you understand it.

----
* Yosemite Sam in "High Diving Hare", 1949

Casey Schaufler
casey@schaufler-ca.com
