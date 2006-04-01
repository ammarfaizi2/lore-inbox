Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751538AbWDAPEI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751538AbWDAPEI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Apr 2006 10:04:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751540AbWDAPEI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Apr 2006 10:04:08 -0500
Received: from smtp-106-saturday.nerim.net ([62.4.16.106]:19473 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S1751538AbWDAPEH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Apr 2006 10:04:07 -0500
Date: Sat, 1 Apr 2006 17:04:22 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Frank Gevaerts <frank@gevaerts.be>
Cc: Robert Love <rlove@rlove.org>, linux-kernel@vger.kernel.org
Subject: Re: patch : hdaps on Thinkpad R52
Message-Id: <20060401170422.cc2ff8c2.khali@linux-fr.org>
In-Reply-To: <20060328170045.GA10334@gevaerts.be>
References: <20060314205758.GA9229@gevaerts.be>
	<20060328182933.4184db3f.khali@linux-fr.org>
	<20060328170045.GA10334@gevaerts.be>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frank,

> > I have some doubt about this. The Thinkpad R52 is already supported
> > (with identifier string "ThinkPad R52", unsuprisingly) and "ThinkPad H"
> > doesn't exactly sound sane. Looks like your DMI data is corrupted or
> > something. Could you please provide the output of dmidecode and
> > vpddecode on your laptop?
> 
> They are attached.

> # dmidecode 2.8
> (...)
> System Information
> 	Manufacturer: IBM
> 	Product Name: 1846AQG
> 	Version: ThinkPad H   

OK, so as strange as it sounds, that's really the string as stored in
the DMI table. How odd... You have to understand that I'm a bit
reluctant to adding it officially to the hdaps driver, given that it
clearly looks like a bogus table in your laptop. I guess that you only
have one laptop with this string?

Can you please check for a BIOS update for your laptop? Maybe that will
fix the string.

Thanks,
-- 
Jean Delvare
