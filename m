Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030321AbWAROQj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030321AbWAROQj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 09:16:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030324AbWAROQj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 09:16:39 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:61457 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1030321AbWAROQi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 09:16:38 -0500
Date: Sun, 15 Jan 2006 15:13:45 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Shaohua Li <shaohua.li@intel.com>
Cc: ronald.mythtv@gmail.com, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: /proc/acpi/alarm -- does it work or not?
Message-ID: <20060115151345.GA2694@ucw.cz>
References: <59D45D057E9702469E5775CBB56411F1013CF084@pdsmsx406> <20060109154416.GF717@atrey.karlin.mff.cuni.cz> <1136863261.5750.4.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1136863261.5750.4.camel@sli10-desk.sh.intel.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > pavel@amd:/data/l/linux$
> > 
> > ...but /proc/acpi/alarm still behaves very strangely:
> > 
> > 2006-01-00 12:42:00
> > root@amd:/proc/acpi# echo '2006-01-01 12:34:56' > alarm
> > root@amd:/proc/acpi# cat alarm
> > 2006-01-01 12:34:56
> > root@amd:/proc/acpi# echo '2006-09-01 12:34:56' > alarm
> > root@amd:/proc/acpi# cat alarm
> > 2006-01-01 12:34:56
> > root@amd:/proc/acpi# echo '2006-01-09 12:34:56' > alarm
> > root@amd:/proc/acpi# cat alarm
> > 2006-01-09 12:34:56
> > root@amd:/proc/acpi# echo '2006-02-09 12:34:56' > alarm
> > root@amd:/proc/acpi# cat alarm
> > 2006-01-09 12:34:56
> > root@amd:/proc/acpi#
> > 
> > ...why does it hate february and september?
> No. Setting day, month, century for alarm is optional. This means your
> system doesn't support setting month and century. But maybe we should
> print some infos here ...

Yes, more info would be nice. What is "correct" way to test
if systen supports day/month/year/century in alarm?
						Pavel
-- 
Thanks, Sharp!
