Return-Path: <linux-kernel-owner+w=401wt.eu-S1423040AbWLUTPU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423040AbWLUTPU (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 14:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423043AbWLUTPU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 14:15:20 -0500
Received: from yumi.tdiedrich.de ([85.10.210.183]:4070 "EHLO yumi.tdiedrich.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423040AbWLUTPS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 14:15:18 -0500
Date: Thu, 21 Dec 2006 20:15:13 +0100
From: Tobias Diedrich <ranma+kernel@tdiedrich.de>
To: Yinghai Lu <yinghai.lu@amd.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>
Subject: Re: IO-APIC + timer doesn't work
Message-ID: <20061221191513.GA5824@melchior.yamamaya.is-a-geek.org>
Mail-Followup-To: Tobias Diedrich <ranma+kernel@tdiedrich.de>,
	Yinghai Lu <yinghai.lu@amd.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>
References: <20061216225338.GA2616@melchior.yamamaya.is-a-geek.org> <20061216230605.GA2789@melchior.yamamaya.is-a-geek.org> <Pine.LNX.4.64.0612161518080.3479@woody.osdl.org> <20061217145714.GA2987@melchior.yamamaya.is-a-geek.org> <m1bqm1s5vv.fsf@ebiederm.dsl.xmission.com> <20061218152333.GA2400@melchior.yamamaya.is-a-geek.org> <m1tzztqkev.fsf@ebiederm.dsl.xmission.com> <86802c440612190000k7eb5e68et9c0a776ef85b5177@mail.gmail.com> <m1ac1kqg6b.fsf@ebiederm.dsl.xmission.com> <86802c440612192250l50805d40h71baa7ce6f99a3e5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <86802c440612192250l50805d40h71baa7ce6f99a3e5@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yinghai Lu wrote:
> On 12/19/06, Eric W. Biederman <ebiederm@xmission.com> wrote:
> >So the pin2 case should be tested right after the pin1 case as we do
> >currently.  On most new boards that will be a complete noop.
> >
> >But it is better than our current blind guess at using ExtINT mode.
> >
> >I figure after we try what the BIOS has told us about and that
> >has failed we should first try the common irq 0 apic mappings,
> >and then try the common ExtINT mappings.
> 
> Please check if this one is ok.

Works fine for me.

FYI I'm off to my parents from Saturday onward, so after that I
can't test any patches for the next one or two weeks.

-- 
Tobias						PGP: http://9ac7e0bc.uguu.de
このメールは十割再利用されたビットで作られています。
