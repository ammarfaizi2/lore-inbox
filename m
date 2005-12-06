Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751506AbVLFAJG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751506AbVLFAJG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 19:09:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751507AbVLFAJG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 19:09:06 -0500
Received: from mail.enyo.de ([212.9.189.167]:28056 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S1751506AbVLFAJF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 19:09:05 -0500
From: Florian Weimer <fw@deneb.enyo.de>
To: Bernd Petrovitsch <bernd@firmix.at>
Cc: Lee Revell <rlrevell@joe-job.com>,
       Matthias Andree <matthias.andree@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
References: <20051203135608.GJ31395@stusta.de>
	<1133620264.2171.14.camel@localhost.localdomain>
	<20051203193538.GM31395@stusta.de>
	<1133639835.16836.24.camel@mindpipe>
	<20051203225815.GH25722@merlin.emma.line.org>
	<1133653782.19768.1.camel@mindpipe> <87u0dn5k6m.fsf@mid.deneb.enyo.de>
	<1133818877.21641.92.camel@mindpipe>
	<87mzjf409y.fsf@mid.deneb.enyo.de>
	<1133824015.3562.5.camel@gimli.at.home>
Date: Tue, 06 Dec 2005 01:08:57 +0100
In-Reply-To: <1133824015.3562.5.camel@gimli.at.home> (Bernd Petrovitsch's
	message of "Tue, 06 Dec 2005 00:06:55 +0100")
Message-ID: <87y82z2ijq.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Bernd Petrovitsch:

> On Tue, 2005-12-06 at 00:00 +0100, Florian Weimer wrote:
> [...]
>> fixes (and other critical bug fixes).  For picking functionality, I
>> agree, but critical bug fixes which basically affect everone are a
>> different matter.  It doesn't make sense to redo the same analysis
>> over and over again, at each vendor.
>
> Then vendors should cooperate/collaborate. Where's the problem?

Usually, publicly visisble security bug handling is not separated from
the main development effort, especially if there is already a
centralized team for that purpose.

It's also a waste of resources if someone with no detailed knowledge
of the first analysis (which was made when the bug was fixed) or the
source code in question has to redo the whole analysis, just to pick
up the correct patches and classify the vulnerability.  If you
duplicate the work just once, things are a bit better, but it's still
a waste of resources, and people not familiar with the code tend to
make more mistakes.

It's not that there isn't any cooperation, either.  As far as I can
tell, it's possible to get most insider know-how on vulnerabilities
once it is published.  It's just more time-consuming than necessary.
