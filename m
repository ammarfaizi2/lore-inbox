Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290273AbSAOU3K>; Tue, 15 Jan 2002 15:29:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289646AbSAOU2p>; Tue, 15 Jan 2002 15:28:45 -0500
Received: from willow.seitz.com ([207.106.55.140]:57868 "EHLO willow.seitz.com")
	by vger.kernel.org with ESMTP id <S289643AbSAOU0x>;
	Tue, 15 Jan 2002 15:26:53 -0500
From: Ross Vandegrift <ross@willow.seitz.com>
Date: Tue, 15 Jan 2002 15:26:43 -0500
To: "Eric S. Raymond" <esr@thyrsus.com>, linux-kernel@vger.kernel.org,
        kbuild-devel@lists.sourceforge.net
Subject: Re: CML2-2.1.3 is available
Message-ID: <20020115152643.A6846@willow.seitz.com>
In-Reply-To: <20020115145324.A5772@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020115145324.A5772@thyrsus.com>; from esr@thyrsus.com on Tue, Jan 15, 2002 at 02:53:24PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The interactive configurators remain stable; no bugs of any kind have been 
> reported since 6 Jan.  I'm waiting on an update of the probe tables from
> Giacomo Catenazzi before releasing 2.2.0.

I tried CML2 (2.1.2) yesterday with Linux 2.4.17 and found that I couldn't turn
on suppression ('S' didn't seem to toggle, only disable suppression, which was
already off) and entering into a submenu marked FROZEN locked up the
configurator.

It seems the second issue is related to the first; if I move off of the "Inter
or Processor type (FROZEN)" selection, I'm not allowed to go back and select it.
However, when just starting, it is the default selection.

If I then press 'S' I get the "Suppression turned off" message, but still cannot
move the selection back onto "Intel or Processor type (FROZEN)".  CTRL-C gets me
back to a prompt, no other keys initiated a response.

I'm using Python 2.0.1 with Slackware 8.

Ross Vandegrift
ross@willow.seitz.com
