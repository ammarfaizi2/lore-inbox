Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932084AbWBFNbS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932084AbWBFNbS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 08:31:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932089AbWBFNbS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 08:31:18 -0500
Received: from smtpout.mac.com ([17.250.248.73]:31985 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932084AbWBFNbS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 08:31:18 -0500
In-Reply-To: <p73hd7clp5k.fsf@verdi.suse.de>
References: <43E64791.8010302@namesys.com> <43E6521F.5020707@suse.com> <43E6BF48.5010301@namesys.com> <BAFD888C-7E6B-49B1-A394-901D24CFBCBF@mac.com> <p73hd7clp5k.fsf@verdi.suse.de>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <96DB44F5-85D3-4F78-8417-D5AB9303D696@mac.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jeff Mahoney <jeffm@suse.com>,
       LKML <linux-kernel@vger.kernel.org>, kernel-bugzilla@luksan.cjb.net
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: quality control
Date: Mon, 6 Feb 2006 08:31:04 -0500
To: Andi Kleen <ak@suse.de>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 06, 2006, at 06:09, Andi Kleen wrote:
> Kyle Moffett <mrmacman_g4@mac.com> writes:
>> It's a GIT version of an RC patch for grief's sake!  You don't  
>> seriously expect people to quadruple-check every trivial patch  
>> that goes into Linus GIT tree before sending it, do you?
>
> No quadruple check, but every patch going to Linus should get at  
> least some basic testing and it's definitely suppose to compile at  
> least in one .config combination.

Well, yes, and it did.  The problem was that if you turned off ACLs,  
it didn't work; only one or two variants of about 6 or 8 ways to  
configure reiserfs stopped working.  Given that, I can't see how Hans  
is complaining about lack of QC.  Nobody is going to test patches  
against every possible kernel configuration; that's why we do an RC,  
so that we can get a lot of different configs tested.

Cheers,
Kyle Moffett

--
I didn't say it would work as a defense, just that they can spin that  
out for years in court if it came to it.
   -- Rob Landley



