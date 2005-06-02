Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261189AbVFBQWV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261189AbVFBQWV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 12:22:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261187AbVFBQWU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 12:22:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:14209 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261182AbVFBQWF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 12:22:05 -0400
Message-ID: <429F321D.9000009@suse.de>
Date: Thu, 02 Jun 2005 18:21:49 +0200
From: Stefan Seyfried <seife@suse.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041207 Thunderbird/1.0 Mnenhy/0.7.2.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC] Add some hooks to generic suspend code
References: <1117524577.5826.35.camel@gaston>	<20050531101344.GB9614@elf.ucw.cz>	<1117550660.5826.42.camel@gaston> <20050531212556.GA14968@elf.ucw.cz>
In-Reply-To: <20050531212556.GA14968@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:

> Anyway, it should not be arch-dependend. We need one good mechanism of
> notifying userland, not one per architecture.

Yes.

>> Sure, ideally. However, existing X knows how to deal with APM events,
>> and thus APM emulation is an important thing to get something that
>> works. Pne thing I should do is consolidate PPC APM emu with ARM one as
>> I think Russell improve my stuff significantly.
> 
> Perhaps we need apm emulation on i386, too?

No. This is too ugly for words IMO. If we have one good mechanism of
notifying userland, X can use this mechanism. Let's kill APM, not keep
it alive.
-- 
Stefan Seyfried
QA / R&D Team Mobile Devices        |              "Any ideas, John?"
SUSE LINUX Products GmbH, Nürnberg  | "Well, surrounding them's out."
