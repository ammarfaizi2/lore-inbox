Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261797AbTILSDn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 14:03:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261804AbTILSDn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 14:03:43 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:18183
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S261797AbTILSDf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 14:03:35 -0400
Date: Fri, 12 Sep 2003 11:03:38 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Andi Kleen <ak@suse.de>, akpm@osdl.org,
       richard.brunner@amd.com, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
Message-ID: <20030912180338.GC30584@matchmail.com>
Mail-Followup-To: "Eric W. Biederman" <ebiederm@xmission.com>,
	Jeff Garzik <jgarzik@pobox.com>, Andi Kleen <ak@suse.de>,
	akpm@osdl.org, richard.brunner@amd.com,
	linux-kernel@vger.kernel.org, torvalds@osdl.org
References: <99F2150714F93F448942F9A9F112634C0638B196@txexmtae.amd.com> <20030911012708.GD3134@wotan.suse.de> <20030910184414.7850be57.akpm@osdl.org> <20030911014716.GG3134@wotan.suse.de> <3F60837D.7000209@pobox.com> <20030911162634.64438c7d.ak@suse.de> <3F6087FC.7090508@pobox.com> <m1vfrxlxol.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1vfrxlxol.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 12, 2003 at 11:32:42AM -0600, Eric W. Biederman wrote:
> The size of a minimal bzImage (the stuff you can't compile out) has
> increased by roughly 400KB since 1.0 200KB since 2.2 and 100KB since 2.4.
> 
> So please pardon those of us who complain at things that can't be
> configured out.  The x86 kernel is on the edge of becoming useless
> in some embedded scenarios because it is so fat.
> 
> When we can compile out code, we can at least narrow down where the
> problems are.
> 
> I have to agree with Jeff the LinuxBIOS stuff is  crippled right now
> because of this.
> 
> There may be better places to attack.  But new code is what is up for
> examination and is easiest to fix.

Yes, but is there enough framework to make this reasonable?

Is config generic with its new semantics (different from the origional
author) good enough for this?
