Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932148AbWDRCBc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148AbWDRCBc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 22:01:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932143AbWDRCBc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 22:01:32 -0400
Received: from victor.provo.novell.com ([137.65.250.26]:11708 "EHLO
	victor.provo.novell.com") by vger.kernel.org with ESMTP
	id S932073AbWDRCBb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 22:01:31 -0400
Message-ID: <4444484E.2040203@novell.com>
Date: Mon, 17 Apr 2006 19:00:46 -0700
From: Crispin Cowan <crispin@novell.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Gerrit Huizenga <gh@us.ibm.com>, James Morris <jmorris@namei.org>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Stephen Smalley <sds@tycho.nsa.gov>, casey@schaufler-ca.com,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
       fireflier-devel@lists.sourceforge.net, chrisw@sous-sol.org
Subject: Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks
References: <E1FVc0H-00077d-00@w-gerrit.beaverton.ibm.com> <1145314085.14793.35.camel@localhost.localdomain>
In-Reply-To: <1145314085.14793.35.camel@localhost.localdomain>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Llu, 2006-04-17 at 15:15 -0700, Gerrit Huizenga wrote:
>   
>> something like AppArmour provides a much simpler security model for
>>     
> If the AppArmour people care to submit their code upstream and get it
> merged then that would be a reason to keep LSM, if they don't then LSM
> (if they even want it..) can just become part of their patchkit instead.
>   
Indeed, this thread is timely.  We (SUSE) opensourced the user-level
AppArmor http://www.opensuse.org/AppArmor tools in January 2006
http://www.securityfocus.com/brief/103  and
http://lwn.net/Articles/166975/ and the kernel module has always been
open source.

We have been hard at work on making the code as CodingStyle-compliant as
we can since then, with the intent of submitting it for inclusion in the
kernel. We actually planned to submit it later this week, but in light
of this thread, we cut a few corners and expect to post our first
proposed patches here by about Wednesday.

Crispin
-- 
Crispin Cowan, Ph.D. http://crispincowan.com/~crispin/
Director of Software Engineering, Novell http://novell.com
