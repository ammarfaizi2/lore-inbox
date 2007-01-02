Return-Path: <linux-kernel-owner+w=401wt.eu-S932740AbXABKpA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932740AbXABKpA (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 05:45:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932770AbXABKpA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 05:45:00 -0500
Received: from mx1.suse.de ([195.135.220.2]:43704 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932740AbXABKo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 05:44:59 -0500
Date: Tue, 2 Jan 2007 11:44:38 +0100
From: Stefan Seyfried <seife@suse.de>
To: Paolo Ornati <ornati@fastwebnet.it>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: s2disk curiosity  :)
Message-ID: <20070102104438.GB8693@suse.de>
References: <20061218100612.02d807f7@localhost> <20061218093624.GC960@suse.de> <20061218111451.5ffce963@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20061218111451.5ffce963@localhost>
X-Operating-System: openSUSE 10.2 (i586), Kernel 2.6.18.2-34-default
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 18, 2006 at 11:14:51AM +0100, Paolo Ornati wrote:
> On Mon, 18 Dec 2006 10:36:24 +0100
> Stefan Seyfried <seife@suse.de> wrote:
> 
> > It depends on the BIOS. Many BIOSes have a setting where you can set the
> > "power fail mode" to "on", "off" or "as before".
> 
> Ok, I've found the BIOS setting: Restore on AC Poer Loss = {Power Off,
> Power On, Last State}.
> 
> Anyway I found strange that the "state" after s2disk is considered
> "ON"  ;)

Well, that is a decision of your BIOS, 'if the machine was suspended,
treat "Restore on AC Power Loss" as "on" temporarily'. I don't know
if there is anything that linux can do for you in this case, but you
still can at least use shutdown mode to just "not tell the BIOS that
we suspended" :-)
-- 
Stefan Seyfried
QA / R&D Team Mobile Devices        |              "Any ideas, John?"
SUSE LINUX Products GmbH, Nürnberg  | "Well, surrounding them's out." 
