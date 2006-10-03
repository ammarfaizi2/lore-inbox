Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030587AbWJCWBj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030587AbWJCWBj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 18:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030586AbWJCWBj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 18:01:39 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:46044 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030590AbWJCWBh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 18:01:37 -0400
Subject: Re: [PATCH] IPC namespace core
From: David Woodhouse <dwmw2@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Kirill Korotaev <dev@openvz.org>, Pavel Emelianov <xemul@openvz.org>,
       Cedric Le Goater <clg@fr.ibm.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>
In-Reply-To: <20061003093505.0bb7bb6a.akpm@osdl.org>
References: <200610021601.k92G13mT003934@hera.kernel.org>
	 <1159866174.3438.66.camel@pmac.infradead.org>
	 <20061003093505.0bb7bb6a.akpm@osdl.org>
Content-Type: text/plain; charset=UTF-8
Date: Tue, 03 Oct 2006 23:01:31 +0100
Message-Id: <1159912891.27726.3.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 (2.8.0-7.fc6) 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-10-03 at 09:35 -0700, Andrew Morton wrote:
> We'll get there ;) I'm waiting for a suitable time to merge
> add-config_headers_check-option-to-automatically-run-make-headers_check.patch,
> which will cause all `make allmodconfig' testers to automatically run `make
> headers_check'.
> 
> But I don't think the time is right yet - a little later, when things have
> settled down and when it all works nicely on multiple architectures.

Other than the glitches I just whinged about, it _does_ work nicely on
almost all architectures. I sent Linus those fixes as soon as 2.6.18
came out, and you were talking about putting them in -stable too
(although you went quiet on that front when you saw how many there
were¹).

In fact, I held off on merging some of Arnd's extra checks because I
didn't want to add extra failures -- specifically because I thought we
were turning that config-headers-check thingy on.

-- 
dwmw2

¹ http://git.infradead.org/?p=users/dwmw2/khdrs-2.6.git;a=shortlog;h=stable

