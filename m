Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261217AbVCKRBj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261217AbVCKRBj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 12:01:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261216AbVCKRBi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 12:01:38 -0500
Received: from nepa.nlc.no ([195.159.31.6]:20968 "HELO nepa.nlc.no")
	by vger.kernel.org with SMTP id S261215AbVCKRBh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 12:01:37 -0500
Message-ID: <50265.80.203.9.198.1110560424.squirrel@80.203.9.198>
In-Reply-To: <20050311165526.GA3723@stusta.de>
References: <200503100216.j2A2G2DN015232@ccure.user-mode-linux.org>
    <20050310225340.GD3205@stusta.de>
    <200503111849.j2BImsJp003370@ccure.user-mode-linux.org>
    <20050311165526.GA3723@stusta.de>
Date: Fri, 11 Mar 2005 18:00:24 +0100 (CET)
Subject: Re: [uml-devel] Re: [PATCH 4/9] UML - Export gcov symbol based on 
     gcc version
From: stian@nixia.no
To: "Adrian Bunk" <bunk@stusta.de>
Cc: "Jeff Dike" <jdike@addtoit.com>, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
User-Agent: SquirrelMail/1.4.3a-0.f1.1
X-Mailer: SquirrelMail/1.4.3a-0.f1.1
MIME-Version: 1.0
Content-Type: text/plain;charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > ( (__GNUC__ == 3 && __GNUC_MINOR__ == 3 && __GNUC_PATCHLEVEL__ >= 4)
>> > && \
>> >    HEAVILY_PATCHED_SUSE_GCC )
>> > I hope SuSE has added some #define to distinguish what they call  "gcc
>> > 3.3.4" from GNU gcc 3.3.4
>> It wasn't lost - I am just disinclined to cater to distros making their
>> gcc lie about its version.
> And therefore you added a patch that helps only those distros at the
> price of breaking other people and distros using sane compilers?

A dirty method would be to use a configure prinsip to test-compile, and
have a define that depends on it. Perhaps dirty, conserning kbuild, but
resolves problems, unless the alias symbol works.

Stian
