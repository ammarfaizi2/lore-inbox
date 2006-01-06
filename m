Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030447AbWAGN2h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030447AbWAGN2h (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 08:28:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030448AbWAGN2h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 08:28:37 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:13329 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1030447AbWAGN2h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 08:28:37 -0500
Date: Fri, 6 Jan 2006 00:00:48 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: STR works if suspended for a short time but hangs for extended period
Message-ID: <20060106000048.GB2951@ucw.cz>
References: <200601071154.43300.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601071154.43300.arvidjaar@mail.ru>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat 07-01-06 11:54:42, Andrey Borzenkov wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> I am not sure where to start digging.
> 
> Toshiba Portege 4000, vanilla 2.6.15, Mandriva with suspend-scripts. In 
> principle, both STR and hibernation work. STR works just fine for testing - 
> suspend, resume after several munutes, and everything works just fine. But if 
> I leave system in STR state for several hours, it reliably hangs on resume. I 
> have to hard power off it that has value added annoyance that keyboard is 
> disabled until I turn it off again (using mouse out of kdm :)
> 
> Unless it is a known issue, I appreciate hints where to start debugging. I am 
> not deep into Linu power management issues.

Try it with minimal drivers, vga text mode. Perhaps it is just
device that retains state for 5 minutes but forgets state over
longer periods?

-- 
Thanks, Sharp!
