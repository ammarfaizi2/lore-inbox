Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932661AbVHPLc2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932661AbVHPLc2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 07:32:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932643AbVHPLc2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 07:32:28 -0400
Received: from isilmar.linta.de ([213.239.214.66]:35018 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S932641AbVHPLcZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 07:32:25 -0400
Date: Tue, 16 Aug 2005 10:57:40 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Todd Poynor <tpoynor@mvista.com>, cpufreq@lists.linux.org.uk,
       Patrick Mochel <mochel@digitalimplant.org>, linux-pm@lists.osdl.org,
       linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
Subject: Re: PowerOP 0/3: System power operating point management API
Message-ID: <20050816085740.GL9150@dominikbrodowski.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Todd Poynor <tpoynor@mvista.com>, cpufreq@lists.linux.org.uk,
	Patrick Mochel <mochel@digitalimplant.org>, linux-pm@lists.osdl.org,
	linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
References: <20050809024907.GA25064@slurryseal.ddns.mvista.com> <20050810100718.GC1945@elf.ucw.cz> <42FA796A.4080205@mvista.com> <20050809024907.GA25064@slurryseal.ddns.mvista.com> <Pine.LNX.4.50.0508091110430.19925-100000@monsoon.he.net> <42F963F6.60209@mvista.com> <20050809030000.GA25112@slurryseal.ddns.mvista.com> <20050816085345.GJ9150@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050816085345.GJ9150@dominikbrodowski.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A small add-on:

We need to make sure that we're capable of handling smart CPUs like Transmeta
Crusoe processors in a sane way. This means

> b)	Setting of "values"

is optional if the hardware itself can be set to a min/max value (step a
above in previous mail).

	Dominik
