Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274082AbRIXRlQ>; Mon, 24 Sep 2001 13:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274081AbRIXRlG>; Mon, 24 Sep 2001 13:41:06 -0400
Received: from thor.lineo.com ([204.246.147.11]:2015 "EHLO thor.lineo.com")
	by vger.kernel.org with ESMTP id <S274084AbRIXRkt>;
	Mon, 24 Sep 2001 13:40:49 -0400
Message-ID: <3BAF706E.E0DFA0AA@lineo.com>
Date: Mon, 24 Sep 2001 11:42:06 -0600
From: Tim Bird <tbird@lineo.com>
X-Accept-Language: en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: Binary only module question
In-Reply-To: <20010924124044.B17377@devserv.devel.redhat.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> I'm composing a list of all existing binary only modules,

Will the list be available somewhere?

I'm working on a tool that (among other things) indicates
what is "accepted practice" for loadable modules that
are binary.  I seem to recall Linus saying, some years
ago, something about the the fact that the module must
not be fundamental to basic kernel operation.  I can't remember
the exact details of the quote (if anyone has it, I'd 
appreciate a reference to it), but I thought the general
spirit was that add-on's are OK, but basic functionality
(like the scheduler, memory management, driver
*systems* (not drivers themselves), etc.) were off limits for
being binary modules.

I'm assuming that if a module is currently known, and there
does not appear to be great backlash against it, that it 
is accepted practice.  Also, I assume that modules that
perform essentially the same functionality as these would
also be acceptable (from a community standpoint - the
legal standpoint is a different matter).  Basically, I'm
infering a kind of community precendence from existing
known binary modules?

Am I way off?

(And yes, I know that given a choice, the community
vastly prefers an open source module over a binary module)

____________________________________________________________
Tim Bird                                  Lineo, Inc.
Senior VP, Research                       390 South 400 West
tbird@lineo.com                           Lindon, UT 84042
