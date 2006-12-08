Return-Path: <linux-kernel-owner+w=401wt.eu-S1760078AbWLHUlI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760078AbWLHUlI (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 15:41:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761193AbWLHUlI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 15:41:08 -0500
Received: from web36607.mail.mud.yahoo.com ([209.191.85.24]:25688 "HELO
	web36607.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1761190AbWLHUlF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 15:41:05 -0500
X-YMail-OSG: FtwdYbMVM1mArrCQioH3Iht28Kirz0YSb22xp6A7oJxN66klwx.i50hyfVJm22QA.KIeikLd0dpzcEMmmZq1vqPL.3erG79HDycej1x6H3GfDeIQ1JOpMJzldE4vox4G6hAueKYsalQ-
X-RocketYMMF: rancidfat
Date: Fri, 8 Dec 2006 12:41:04 -0800 (PST)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [PATCH 0/2] file capabilities: two bugfixes
To: "Serge E. Hallyn" <serue@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       linux-security-module@vger.kernel.org, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20061208193657.GB18566@sergelap.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <402572.41716.qm@web36607.mail.mud.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- "Serge E. Hallyn" <serue@us.ibm.com> wrote:

> ...
> The other is that root can lose capabilities by
> executing files with
> only some capabilities set.  The next two patches
> change these
> behaviors.

It was the intention of the POSIX group that
capabilities be independent of uid. I would
argue that the old bevavior was correct, that
a program marked to lose a capability ought
to even if the uid is 0.


Casey Schaufler
casey@schaufler-ca.com
