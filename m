Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270832AbTGVO2j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 10:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270850AbTGVO2j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 10:28:39 -0400
Received: from genius.impure.org.uk ([195.82.120.210]:27619 "EHLO
	genius.impure.org.uk") by vger.kernel.org with ESMTP
	id S270832AbTGVO2h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 10:28:37 -0400
Date: Tue, 22 Jul 2003 15:42:53 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Dominik Brodowski <linux@brodo.de>
Cc: textshell@neutronstar.dyndns.org, linux-kernel@vger.kernel.org,
       Henrik Persson <nix@syndicalist.net>
Subject: Re: 2.6.0-test1: CPUFreq not working, can't find sysfs interface
Message-ID: <20030722144253.GA32119@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Dominik Brodowski <linux@brodo.de>,
	textshell@neutronstar.dyndns.org, linux-kernel@vger.kernel.org,
	Henrik Persson <nix@syndicalist.net>
References: <20030720150243.GJ2331@neutronstar.dyndns.org> <200307201745.h6KHjcHt095999@sirius.nix.badanka.com> <20030720211246.GK2331@neutronstar.dyndns.org> <20030722120811.GD1160@brodo.de> <20030722141839.GD7517@neutronstar.dyndns.org> <20030722142353.GA1301@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030722142353.GA1301@brodo.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 22, 2003 at 04:23:53PM +0200, Dominik Brodowski wrote:
 > On Tue, Jul 22, 2003 at 04:18:39PM +0200, textshell@neutronstar.dyndns.org wrote:
 > > So it seems to me that the BIOS doesn't have the tables for my Athlon
 > > model/stepping. I tried to get a new bios from hp, but it didn't change anything
 > > relevant (they changed something in the PSTs but did not add a new one for my
 > > processor)
 > Indeed, that's the BUG().

Can you also mail the output of dmidecode, and the model of the laptop.
This is a 'beat up BIOS vendor' case, which AMD are actively trying to do.
I'll forward the info on to the right people..


 > > I think it would be a good thing to display a Message explaining why powernow
 > > isn't working to the user in the case that no relevant PST is found.
 > Patch appended at the end.

Looks fine. I'll apply it when I get back from KS/OLS.
 
 > > I very much would like to have a way to override (or add to) the bios provided
 > > values.
 > AFAIK, Dave Jones will add support to override the BIOS-provided tables.

There's been some sysfs discussion with Pat in the last few days
(not specifically cpufreq related, but its going to become easier
 to add this aparently..).

		Dave

