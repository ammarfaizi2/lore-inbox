Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752304AbWAEXqc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752304AbWAEXqc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 18:46:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752303AbWAEXqc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 18:46:32 -0500
Received: from isilmar.linta.de ([213.239.214.66]:59574 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S1751427AbWAEXqb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 18:46:31 -0500
Date: Fri, 6 Jan 2006 00:46:29 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Pavel Machek <pavel@ucw.cz>
Cc: Patrick Mochel <mochel@digitalimplant.org>, Andrew Morton <akpm@osdl.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [linux-pm] [patch] pm: fix runtime powermanagement's /sys interface
Message-ID: <20060105234629.GA7298@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Pavel Machek <pavel@ucw.cz>,
	Patrick Mochel <mochel@digitalimplant.org>,
	Andrew Morton <akpm@osdl.org>,
	Linux-pm mailing list <linux-pm@lists.osdl.org>,
	kernel list <linux-kernel@vger.kernel.org>
References: <d120d5000512271355r48d476canfea2c978c2f82810@mail.gmail.com> <20051227220533.GA1914@elf.ucw.cz> <Pine.LNX.4.50.0512271957410.6491-100000@monsoon.he.net> <20060104213405.GC1761@elf.ucw.cz> <Pine.LNX.4.50.0601051329590.17046-100000@monsoon.he.net> <20060105215528.GF2095@elf.ucw.cz> <20060105221334.GA925@isilmar.linta.de> <20060105222338.GG2095@elf.ucw.cz> <20060105222705.GA12242@isilmar.linta.de> <20060105230849.GN2095@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060105230849.GN2095@elf.ucw.cz>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2006 at 12:08:49AM +0100, Pavel Machek wrote:
> Ok, so lets at least add value-checking to .../power file, and prevent
> userspace see changes to PM_EVENT_SUSPEND value. 2 and 0 are now
> "arbitrary cookies". I'd like to use "on" and "off", but pcmcia
> apparently depends on "2" and "0", so...
> 
> Any objections?

Sorry, but yes -- the same as before, minus the PCMCIA breakage.

	Dominik
