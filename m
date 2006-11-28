Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935734AbWK1QV6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935734AbWK1QV6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 11:21:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935739AbWK1QV6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 11:21:58 -0500
Received: from MAIL.13thfloor.at ([213.145.232.33]:23746 "EHLO
	MAIL.13thfloor.at") by vger.kernel.org with ESMTP id S935734AbWK1QV5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 11:21:57 -0500
Date: Tue, 28 Nov 2006 17:21:56 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Containers <containers@lists.osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] Fix the binary ipc and uts namespace sysctls.
Message-ID: <20061128162156.GF23131@MAIL.13thfloor.at>
Mail-Followup-To: "Eric W. Biederman" <ebiederm@xmission.com>,
	Andrew Morton <akpm@osdl.org>,
	Linux Containers <containers@lists.osdl.org>,
	linux-kernel@vger.kernel.org
References: <m1hcwlmqmp.fsf@ebiederm.dsl.xmission.com> <20061127202211.GB26108@MAIL.13thfloor.at> <m1y7pwldi4.fsf@ebiederm.dsl.xmission.com> <20061128143250.GA23131@MAIL.13thfloor.at> <m1y7pvinta.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1y7pvinta.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2006 at 08:38:25AM -0700, Eric W. Biederman wrote:
> Herbert Poetzl <herbert@13thfloor.at> writes:
> 
> > On Mon, Nov 27, 2006 at 03:40:35PM -0700, Eric W. Biederman wrote:
> >> Herbert Poetzl <herbert@13thfloor.at> writes:
> >> 
> >> > the linux banner needs some attention too, when I get
> >> > around, I'll send a patch for that ...
> >> 
> >> In what sense?
> >> 
> >> I have trouble seeing the banner printed at bootup as being problematic.
> >
> > was it removed from procfs after 2.6.19-rc6
> > (/proc/version  sorry, haven't checked yet)
> 
> I see where you are coming from. Yes that is a potential issue,
> because ultimately that information is utsname information. 
> Given that we don't allow any of that information to be changed
> currently that isn't a 2.6.19 issue.
> 
> Given that it is a don't care as long as we generate the same string
> I don't see a problem with a patch to modify it, to track changes in
> the current uts namespace.

thank you very much,
Herbert

> Eric
