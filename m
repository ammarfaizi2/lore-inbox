Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262534AbTJXTxH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 15:53:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262557AbTJXTxH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 15:53:07 -0400
Received: from fed1mtao03.cox.net ([68.6.19.242]:63908 "EHLO
	fed1mtao03.cox.net") by vger.kernel.org with ESMTP id S262540AbTJXTxD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 15:53:03 -0400
Date: Fri, 24 Oct 2003 12:52:43 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: nico-kernel@schottelius.org, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org
Subject: Re: 3c59x problem with 2.4.6-test[34]
Message-ID: <20031024195243.GB985@ip68-0-152-218.tc.ph.cox.net>
References: <20030907212348.GA836@ip68-0-152-218.tc.ph.cox.net> <20030929151827.GB862@ip68-0-152-218.tc.ph.cox.net> <20031015183505.GA963@ip68-0-152-218.tc.ph.cox.net> <20031017235325.GA957@ip68-0-152-218.tc.ph.cox.net> <20031018122708.GA401@schottelius.org> <20031018041448.6362faee.akpm@osdl.org> <20031024193402.GA985@ip68-0-152-218.tc.ph.cox.net> <20031024124356.212fc590.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031024124356.212fc590.akpm@osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 24, 2003 at 12:43:56PM -0700, Andrew Morton wrote:
> Tom Rini <trini@kernel.crashing.org> wrote:
> >
> > Okay.  First an odd part.  When the card does not work, I didn't get
> >  anything in the syslog with debug=7, but I did get plenty when it works.
> 
> Well that's a big hint.  If no debug output comes out then the driver
> simply isn't being executed.  You'll need to investigate and report on this
> further.  Make sure that you've set `dmesg -n 7' of course...

>From the original message, something is happening:
Sep  6 18:13:57 opus kernel: 0000:00:0e.0: 3Com PCI 3c905B Cyclone 100baseTx at 0xe480. Vers LK1.1.19
Sep  6 18:13:57 opus vmunix:   ***WARNING*** No MII transceivers found!


-- 
Tom Rini
http://gate.crashing.org/~trini/
