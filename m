Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290785AbSAYSs2>; Fri, 25 Jan 2002 13:48:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290779AbSAYSsZ>; Fri, 25 Jan 2002 13:48:25 -0500
Received: from ns.suse.de ([213.95.15.193]:51461 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S290786AbSAYSsD>;
	Fri, 25 Jan 2002 13:48:03 -0500
Date: Fri, 25 Jan 2002 19:48:02 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Dana Lacoste <dana.lacoste@peregrine.com>
Cc: "'Stephan von Krawczynski'" <skraw@ithnet.com>,
        <linux-kernel@vger.kernel.org>
Subject: RE: Machine Check Exception ?
In-Reply-To: <B51F07F0080AD511AC4A0002A52CAB445B2AEC@ottonexc1.ottawa.loran.com>
Message-ID: <Pine.LNX.4.33.0201251946290.31702-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jan 2002, Dana Lacoste wrote:

> I don't get them any more after doing this :
> 1 - switched from IDE to SCSI
> 2 - changed RAM vendors (yes, this was unpleasant)
> and, most significantly :
> 3 - made sure the BIOS had the correct microcode update
>     for the CPU.  the one it had was out of date, and
>     changing to the latest from Intel solved a LOT of
>     instability issues....

Flaky RAM tends to be one of the more popular triggers
of these exceptions, so (2) above was more than likely your
cause as opposed to (3). (1) seems incredibly unlikely
unless it had adverse change on power drain.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

