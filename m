Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293357AbSCJWYC>; Sun, 10 Mar 2002 17:24:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293349AbSCJWXx>; Sun, 10 Mar 2002 17:23:53 -0500
Received: from ns.suse.de ([213.95.15.193]:44813 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S293351AbSCJWXj>;
	Sun, 10 Mar 2002 17:23:39 -0500
To: Andreas Jaeger <aj@suse.de>
Cc: Robert Love <rml@tech9.net>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] syscall interface for cpu affinity
In-Reply-To: <1015784104.1261.8.camel@phantasy> <u8zo1g9nf8.fsf@gromit.moeb>
	<1015793618.928.17.camel@phantasy> <u8bsdw9lvd.fsf@gromit.moeb>
X-Yow: I just bought FLATBUSH from MICKEY MANTLE!
From: Andreas Schwab <schwab@suse.de>
Date: Sun, 10 Mar 2002 23:23:34 +0100
In-Reply-To: <u8bsdw9lvd.fsf@gromit.moeb> (Andreas Jaeger's message of "Sun,
 10 Mar 2002 22:03:02 +0100")
Message-ID: <jeheno83kp.fsf@sykes.suse.de>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) Emacs/21.2.50 (ia64-suse-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Jaeger <aj@suse.de> writes:

|> What I need at the moment is a wrapper - and you can do it two ways:
|> 
|> $ run_with_affinity 1 program arguments...
|> $ (cat 1 > /proc/self/affinity; program arguments...)
|> 
|> The second one is much easier coded ;-)

Apparently not, since that should be

$ (echo 1 > /proc/self/affinity; program arguments...)

:-)

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE GmbH, Deutschherrnstr. 15-19, D-90429 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
