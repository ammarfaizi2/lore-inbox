Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264191AbRFSMLF>; Tue, 19 Jun 2001 08:11:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264194AbRFSMK4>; Tue, 19 Jun 2001 08:10:56 -0400
Received: from ns.suse.de ([213.95.15.193]:29966 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S264191AbRFSMKl>;
	Tue, 19 Jun 2001 08:10:41 -0400
To: Ralph Jones <ralph.jones@altavista.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: pivot_root from non-interactive script
In-Reply-To: <20010619095834.8228.cpmta@c012.sfo.cp.net>
X-Yow: ..  I don't know why but, suddenly, I want to discuss declining I.Q.
 LEVELS with a blue ribbon SENATE SUB-COMMITTEE!
From: Andreas Schwab <schwab@suse.de>
Date: 19 Jun 2001 14:10:39 +0200
In-Reply-To: <20010619095834.8228.cpmta@c012.sfo.cp.net> (Ralph Jones's message of "19 Jun 2001 02:58:34 -0700")
Message-ID: <jeofrk656o.fsf@sykes.suse.de>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) Emacs/21.0.103
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ralph Jones <ralph.jones@altavista.com> writes:

|> Thanks.  Yes it looks as if this might be the case.  Do you have any ideas how I might get around this?  Or do I have to use a different shell?

The latter is probably the easiest.  Or fix /bin/ash to set FD_CLOEXEC on
the file descriptor.

Andreas.

-- 
Andreas Schwab                                  "And now for something
SuSE Labs                                        completely different."
Andreas.Schwab@suse.de
SuSE GmbH, Schanzäckerstr. 10, D-90443 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
