Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966537AbWKYMqn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966537AbWKYMqn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 07:46:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966539AbWKYMqn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 07:46:43 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:57868 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S966537AbWKYMqm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 07:46:42 -0500
Date: Sat, 25 Nov 2006 12:46:30 +0000
From: Pavel Machek <pavel@ucw.cz>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc6: oops on resume when plugged to AC on suspend
Message-ID: <20061125124630.GD4782@ucw.cz>
References: <20061124084734.GB621@gimli>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061124084734.GB621@gimli>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Got it the second time now, so it's time to report:

Is it regression?

> When I suspen while plugged to AC and resume unplugged I get the following
> OOPS:
> 

> [152108.954000] CPU:    1
> [152108.954000] EIP:    0060:[<c0182b3a>]    Tainted: P      VLI

Tainted :-(.

> [152108.954000] EFLAGS: 00010212
> (2.6.19-rc6+ieee80211-ipw3945-ch-46.6+1004-g8cdd79c8-dirty #1)

ipw3945 is big patch... but does it have anything to do with mounting?
sysfs?

> [152108.955000] Process mount (pid: 10404, ti=ef940000 task=f1360030
> task.ti=ef940000)

What was the mount process trying to do at this point?

-- 
Thanks for all the (sleeping) penguins.
