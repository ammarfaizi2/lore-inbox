Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751486AbWAFPAJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751486AbWAFPAJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 10:00:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751489AbWAFPAI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 10:00:08 -0500
Received: from isilmar.linta.de ([213.239.214.66]:57529 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S1751486AbWAFPAH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 10:00:07 -0500
Date: Fri, 6 Jan 2006 16:00:05 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [linux-pm] [patch] pm: fix runtime powermanagement's /sys interface
Message-ID: <20060106150005.GA20242@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Patrick Mochel <mochel@digitalimplant.org>,
	Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
	Linux-pm mailing list <linux-pm@lists.osdl.org>,
	kernel list <linux-kernel@vger.kernel.org>
References: <20060105215528.GF2095@elf.ucw.cz> <20060105221334.GA925@isilmar.linta.de> <20060105222338.GG2095@elf.ucw.cz> <20060105222705.GA12242@isilmar.linta.de> <20060105230849.GN2095@elf.ucw.cz> <20060105234629.GA7298@isilmar.linta.de> <20060105235838.GC3339@elf.ucw.cz> <Pine.LNX.4.50.0601051602560.10428-100000@monsoon.he.net> <20060106001252.GE3339@elf.ucw.cz> <Pine.LNX.4.50.0601051729400.30092-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0601051729400.30092-100000@monsoon.he.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jan 05, 2006 at 05:37:30PM -0800, Patrick Mochel wrote:
> And, appended is a patch to export PM controls for PCI devices. The file
> "pm_possible_states" exports the states a device supports, and "pm_state"
> exports the current state (and provides the interface for entering a
> state).

Your patch doesn't handle the PM dependencies, unfortunately... 

Thanks,
	Dominik
