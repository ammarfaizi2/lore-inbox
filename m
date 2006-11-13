Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755256AbWKMUTF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755256AbWKMUTF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 15:19:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755257AbWKMUTF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 15:19:05 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:27615 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1755256AbWKMUTC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 15:19:02 -0500
Subject: Re: [RFC] Pushing device/driver binding decisions to userspace
From: Arjan van de Ven <arjan@infradead.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Ben Collins <ben.collins@ubuntu.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1163443887.5313.27.camel@mindpipe>
References: <1163374762.5178.285.camel@gullible>
	 <1163404727.15249.99.camel@laptopd505.fenrus.org>
	 <1163443887.5313.27.camel@mindpipe>
Content-Type: text/plain
Organization: Intel International BV
Date: Mon, 13 Nov 2006 21:18:59 +0100
Message-Id: <1163449139.15249.197.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-11-13 at 13:51 -0500, Lee Revell wrote:
> On Mon, 2006-11-13 at 08:58 +0100, Arjan van de Ven wrote:
> > Now; there is a second issue. If the choice for one or the other is
> > consistent, we should consider fixing the kernel drivers to just not
> > advertise the b0rked one.. (this assumes that both drivers are in the
> > kernel and both are open source) 
> 
> Unfortunately it becomes political quickly.  For example the old OSS
> i810_audio driver is still in the kernel even though the ALSA driver
> supports more hardware and provides more functionality because some
> people consider the ALSA driver bloated.

I doubt distros ship both though.... I thought all distros were
alsa-only by now..


also this is a case of "full overlap", which isn't a real problem (it's
just policy which module to load); the problem is when you NEED 2
modules to get full coverage and then they overlap..


-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

