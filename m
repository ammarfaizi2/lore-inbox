Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751042AbWIZKMk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751042AbWIZKMk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 06:12:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751054AbWIZKMj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 06:12:39 -0400
Received: from mx1.suse.de ([195.135.220.2]:16532 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751037AbWIZKMj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 06:12:39 -0400
Date: Tue, 26 Sep 2006 12:12:30 +0200
From: Stefan Seyfried <seife@suse.de>
To: Pavel Machek <pavel@ucw.cz>
Cc: Nigel Cunningham <ncunningham@linuxmail.org>, linux-kernel@vger.kernel.org,
       "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>
Subject: Re: When will the lunacy end? (Was Re: [PATCH] uswsusp: add pmops->{prepare,enter,finish} support (aka "platform mode"))
Message-ID: <20060926101230.GD5782@suse.de>
References: <20060925071338.GD9869@suse.de> <1159220043.12814.30.camel@nigel.suspend2.net> <20060925223435.GA2540@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060925223435.GA2540@elf.ucw.cz>
X-Operating-System: SUSE Linux Enterprise Desktop 10 (i586), Kernel 2.6.18-3-seife
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2006 at 12:34:35AM +0200, Pavel Machek wrote:

> PMOPS_PREPARE (& friends) is "tell ACPI to light up that moon
> symbol". Useful suspend can be done without that, but ACPI will be
> confused on resume.

Just to make sure Andrew does not get confused: it also ensures on many
machines, that changed hardware (unplugged AC adapters) gets correctly
detected and that kacpid does not run wild after resume.

I personally would not really care too much about the moon symbol on the
thinkpads, but i care about the ac_adapter state being right :-)

-- 
Stefan Seyfried
QA / R&D Team Mobile Devices        |              "Any ideas, John?"
SUSE LINUX Products GmbH, Nürnberg  | "Well, surrounding them's out." 
