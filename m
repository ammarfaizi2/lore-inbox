Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132709AbRDQW7h>; Tue, 17 Apr 2001 18:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132710AbRDQW71>; Tue, 17 Apr 2001 18:59:27 -0400
Received: from relay1.pair.com ([209.68.1.20]:32271 "HELO relay1.pair.com")
	by vger.kernel.org with SMTP id <S132709AbRDQW7S>;
	Tue, 17 Apr 2001 18:59:18 -0400
X-pair-Authenticated: 203.164.4.223
From: "Manfred Bartz" <md-linux-kernel@logi.cc>
Message-ID: <20010417225850.15245.qmail@logi.cc>
To: linux-kernel@vger.kernel.org
Subject: Re: IP Acounting Idea for 2.5
In-Reply-To: <BF9651D8732ED311A61D00105A9CA3150446DA39@berkeley.gci.com>
X-Subversion: anarchy bomb crypto drug explosive fission gun nuclear sex terror
In-Reply-To: Leif Sawyer's message of "Tue, 17 Apr 2001 13:48:21 -0800"
Organization: rows-n-columns
Date: 18 Apr 2001 08:58:49 +1000
User-Agent: Gnus/5.0803 (Gnus v5.8.3) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Leif Sawyer <lsawyer@gci.com> writes:

> > > Jesse Pollard replies:

> > Removing/no-oping the reset code would make the module
> > SMALLER, and simpler.

> NO.  Don't remove the functionality that is required.  

Please explain where counter reset capability provides any 
functionality that is not already available without it.

You might want to read RFC2724 ``Traffic Flow Measurement''.
Search for ``reset''.

Counter resets have always caused problems, that's why mission 
critical counters never have a reset.  Have you ever seen an
electricity, gas or water meter with a reset?  The same reasoning
applies when you have accounting rules that are used to charge
customers for traffic volume.

> Fix your userspace applications to behave correctly.  If _you_
> require your userspace applications to not clear counters, then fix
> the application.

You are confused.  What would you say if a close() by another,
unrelated application closed all open descriptors for that file,
including the one you just opened?  Just fix your applications?

-- 
Manfred Bartz
