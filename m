Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263399AbTDSPdc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Apr 2003 11:33:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263401AbTDSPdc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Apr 2003 11:33:32 -0400
Received: from ns.suse.de ([213.95.15.193]:3347 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263399AbTDSPdb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Apr 2003 11:33:31 -0400
To: Robert Love <rml@tech9.net>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: mknod64(1)
X-Yow: Now I understand the meaning of ``THE MOD SQUAD''!
From: Andreas Schwab <schwab@suse.de>
Date: Sat, 19 Apr 2003 17:45:29 +0200
In-Reply-To: <1050701464.745.52.camel@localhost> (Robert Love's message of
 "18 Apr 2003 17:31:04 -0400")
Message-ID: <jed6ji5w4m.fsf@sykes.suse.de>
User-Agent: Gnus/5.090018 (Oort Gnus v0.18) Emacs/21.3.50 (gnu/linux)
References: <1050700383.745.48.camel@localhost>
	<b7pqf5$kqv$1@cesium.transmeta.com> <1050701464.745.52.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love <rml@tech9.net> writes:

|> On Fri, 2003-04-18 at 17:24, H. Peter Anvin wrote:
|> 
|> > What would probably be useful for mknod(1), if it doesn't already, is
|> > to allow the major/minor to be specified in any of the standard bases,
|> > i.e. using strtoul(...,...,0).
|> 
|> mknod(1) does not, I think.  Actually, maybe it does... it uses some
|> coreutils wrapper.

The wrapper is essentially calling strtol in the end, so yes, coreutils'
mknod does support the standard bases.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Deutschherrnstr. 15-19, D-90429 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
