Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752332AbWKBVWJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752332AbWKBVWJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 16:22:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752360AbWKBVWJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 16:22:09 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:266 "EHLO spitz.ucw.cz")
	by vger.kernel.org with ESMTP id S1752332AbWKBVWG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 16:22:06 -0500
Date: Thu, 2 Nov 2006 21:20:32 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
       Shem Multinymous <multinymous@gmail.com>,
       David Zeuthen <davidz@redhat.com>, Richard Hughes <hughsient@gmail.com>,
       David Woodhouse <dwmw2@infradead.org>, Dan Williams <dcbw@redhat.com>,
       linux-kernel@vger.kernel.org, devel@laptop.org, sfr@canb.auug.org.au,
       len.brown@intel.com, benh@kernel.crashing.org,
       linux-thinkpad mailing list <linux-thinkpad@linux-thinkpad.org>,
       Jean Delvare <khali@linux-fr.org>
Subject: Re: [ltp] Re: [PATCH v2] Re: Battery class driver.
Message-ID: <20061102212032.GC4887@ucw.cz>
References: <1162041726.16799.1.camel@hughsie-laptop> <1162048148.2723.61.camel@zelda.fubar.dk> <41840b750610281112q7790ecao774b3d1b375aca9b@mail.gmail.com> <20061031074946.GA7906@kroah.com> <41840b750610310528p4b60d076v89fc7611a0943433@mail.gmail.com> <20061101193134.GB29929@kroah.com> <41840b750611011153w3a2ace72tcdb45a446e8298@mail.gmail.com> <20061101205330.GA2593@kroah.com> <20061101235540.GA11581@khazad-dum.debian.net> <454A2FC2.4060107@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <454A2FC2.4060107@tmr.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >Well, "Wh" measures energy and not power, and "Ah" 
> >measures electric charge
> >and not current, so it would be better to make that:
> >
> >capacity_*_energy  (Wh-based)
> >
> >and
> >
> >capacity_*_charge  (Ah-based)
> >
> >Also, should we go with mWh/mAh, or with even smaller 
> >units because of the
> >tiny battery-driven devices of tomorrow?
> >
> Having seen a French consultant with a Windows laptop 
> reporting mJ (Joules) I bet that came from the hardware. 
> And given that laptop batteries run at (almost) constant 
> voltage, could all of these just be converted to mWh for 
> consistency?

li-ions run from 4.2V down to 3.6V without problems, and you can use
them down to 3.0V. I've ran zaurus down to 3.3V, IIRC. That's quite a
big range.

-- 
Thanks for all the (sleeping) penguins.
