Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750708AbWDSBtE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbWDSBtE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 21:49:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750715AbWDSBtE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 21:49:04 -0400
Received: from web36606.mail.mud.yahoo.com ([209.191.85.23]:50575 "HELO
	web36606.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750708AbWDSBtB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 21:49:01 -0400
Message-ID: <20060419014857.35628.qmail@web36606.mail.mud.yahoo.com>
X-RocketYMMF: rancidfat
Date: Tue, 18 Apr 2006 18:48:56 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks
To: James Morris <jmorris@namei.org>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
       fireflier-devel@lists.sourceforge.net
In-Reply-To: <Pine.LNX.4.64.0604181933290.29123@d.namei>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- James Morris <jmorris@namei.org> wrote:


> With pathnames, there is an unbounded and unknown
> number of effective 
> security policies on the system, as there are an
> unbounded and unknown 
> number of ways of viewing the files via pathnames.

I agree that for traditional DAC and MAC (including
the flavors supported by SELinux) inodes is the
only way to go. SELinux is a traditional Trusted OS
architecture and addresses the traditional Trusted
OS issues. 

But as someone demonstrated earlier, not everyone
believes that an EAL makes them feel secure and that
is what LSM is really all about, allowing people
who don't care about Protection Profiles but who do
care about security to do something about it. How
many of you have lambasted me over the years because
I bled Orange? If SELinux is the only "secure" Linux
haven't the Orange Book/Common Criteria people proven
right in the end?




Casey Schaufler
casey@schaufler-ca.com
