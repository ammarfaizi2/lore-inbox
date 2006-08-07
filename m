Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932184AbWHGQyv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932184AbWHGQyv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 12:54:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932223AbWHGQyu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 12:54:50 -0400
Received: from mail.gmx.net ([213.165.64.20]:17858 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932184AbWHGQyt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 12:54:49 -0400
X-Authenticated: #5039886
Date: Mon, 7 Aug 2006 18:54:52 +0200
From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
To: Shem Multinymous <multinymous@gmail.com>
Cc: Pavel Machek <pavel@suse.cz>, Robert Love <rlove@rlove.org>,
       Jean Delvare <khali@linux-fr.org>, Greg Kroah-Hartman <gregkh@suse.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       hdaps-devel@lists.sourceforge.net
Subject: Re: [PATCH 01/12] thinkpad_ec: New driver for ThinkPad embedded controller access
Message-ID: <20060807165452.GB26224@atjola.homenet>
Mail-Followup-To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Shem Multinymous <multinymous@gmail.com>,
	Pavel Machek <pavel@suse.cz>, Robert Love <rlove@rlove.org>,
	Jean Delvare <khali@linux-fr.org>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
	hdaps-devel@lists.sourceforge.net
References: <11548492171301-git-send-email-multinymous@gmail.com> <11548492242899-git-send-email-multinymous@gmail.com> <20060807134440.GD4032@ucw.cz> <41840b750608070813s6d3ffc2enefd79953e0b55caa@mail.gmail.com> <20060807162743.GA26224@atjola.homenet> <41840b750608070941i521fe56crebc491589a67cb59@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <41840b750608070941i521fe56crebc491589a67cb59@mail.gmail.com>
User-Agent: Mutt/1.5.12-2006-07-14
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006.08.07 19:41:11 +0300, Shem Multinymous wrote:
> On 8/7/06, Björn Steinbrink <B.Steinbrink@gmx.de> wrote:
> >On 2006.08.07 18:13:06 +0300, Shem Multinymous wrote:
> >> >> +     struct dmi_device *dev = NULL;
> >> >unneeded initializer.
> >> On a local variable?!
> >
> >You assign a new value to it on the next line, without ever using its
> >initial value.
> 
> The initial value is used in the last parameter to dmi_find_device():
> 
> 	struct dmi_device *dev = NULL;
> 	while ((dev = dmi_find_device(type, NULL, dev))) {
> 		if (strstr(dev->name, substr))
> 			return 1;
> 	}

Sorry, somehow my brain skipped the end of the line.

Björn
