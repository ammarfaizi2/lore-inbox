Return-Path: <linux-kernel-owner+w=401wt.eu-S1754936AbWL1TFo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754936AbWL1TFo (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 14:05:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754937AbWL1TFo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 14:05:44 -0500
Received: from mail.cc.tut.fi ([130.230.1.120]:60708 "EHLO outbox.tut.fi"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754928AbWL1TFn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 14:05:43 -0500
Date: Thu, 28 Dec 2006 21:05:41 +0200
From: Petri Kaukasoina <kaukasoina610meov7e@sci.fi>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Marc Haber <mh+linux-kernel@zugschlus.de>, Andrew Morton <akpm@osdl.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, andrei.popa@i-neo.ro,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Hugh Dickins <hugh@veritas.com>, Florian Weimer <fw@deneb.enyo.de>,
       Martin Michlmayr <tbm@cyrius.com>
Subject: Re: 2.6.19 file content corruption on ext3
Message-ID: <20061228190541.GA23128@elektroni.phys.tut.fi>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Marc Haber <mh+linux-kernel@zugschlus.de>,
	Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
	andrei.popa@i-neo.ro,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Hugh Dickins <hugh@veritas.com>, Florian Weimer <fw@deneb.enyo.de>,
	Martin Michlmayr <tbm@cyrius.com>
References: <1166362772.8593.2.camel@localhost> <20061217154026.219b294f.akpm@osdl.org> <Pine.LNX.4.64.0612171716510.3479@woody.osdl.org> <Pine.LNX.4.64.0612171725110.3479@woody.osdl.org> <Pine.LNX.4.64.0612171744360.3479@woody.osdl.org> <45861E68.3060403@yahoo.com.au> <20061217214308.62b9021a.akpm@osdl.org> <20061219085149.GA20442@torres.l21.ma.zugschlus.de> <20061228180536.GB7385@torres.zugschlus.de> <Pine.LNX.4.64.0612281014190.4473@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612281014190.4473@woody.osdl.org>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 28, 2006 at 11:00:46AM -0800, Linus Torvalds wrote:
> And I have a test-program that shows the corruption _much_ easier (at 
> least according to my own testing, and that of several reporters that back 
> me up), and that seems to show the corruption going way way back (ie going 
> back to Linux-2.6.5 at least, according to one tester).

That was a Fedora kernel. Has anyone seen the corruption in vanilla 2.6.18
(or older)?
