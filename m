Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262431AbREUJzx>; Mon, 21 May 2001 05:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262432AbREUJzo>; Mon, 21 May 2001 05:55:44 -0400
Received: from smtp1.cern.ch ([137.138.128.38]:58641 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S262431AbREUJzb>;
	Mon, 21 May 2001 05:55:31 -0400
To: Ben Ford <ben@kalifornia.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [kbuild-devel] Re: CML2 design philosophy heads-up
In-Reply-To: <20010520185827.B16356@thune.mrc-home.com> <3B08B6B0.4010907@kalifornia.com>
From: Jes Sorensen <jes@sunsite.dk>
Date: 21 May 2001 11:55:15 +0200
In-Reply-To: Ben Ford's message of "Sun, 20 May 2001 23:33:20 -0700"
Message-ID: <d3snhzowl8.fsf@lxplus015.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Ben" == Ben Ford <ben@kalifornia.com> writes:

Ben> Mike Castle wrote:
>>  People who are going to be savvy enough to install a development
>> 2.5.* kernel that is defining a new configuration utility are going
>> to be savvy enough to install python.
>> 
Ben> Not only that, but Alan said that somebody is rewriting it in C.

No and yes, the Python 2 issue is not reasonable, the C version of it
is. Hopefully with a proper C version, the Python 2 dependencies will
go away completely and that part of the discussion becomes moot.

The Python 2 one is a major issue, some people compile current kernels
because thats all that exists for their hardware. Some people who are
bringing up new architectures etc. wants to be self hosting but things
like Perl and Python are not exactly the first things you build. You
may not have threads, you may not have proper math support, maybe no
shared libraries, but that wont stop you from getting
gcc/binutils/bash going. The argument I got from Eric at the 2.5
kernel summit when I first brought this up was 'just configure your
kernel on another machine and copy it over'. Thats extremely naiive,
in some cases you do not have network nor floppy. You copy your
sources over once (so you can hack on the network driver :), you don't
want to have to rip out the disk every time you need a change to the
.config because some obscure option doesn't compile and you hadn't
noticed.

It's just not that trivial.

Jes
