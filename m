Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262334AbVDLOgZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262334AbVDLOgZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 10:36:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262394AbVDLOdA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 10:33:00 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:23276 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262334AbVDLLEy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 07:04:54 -0400
Date: Tue, 12 Apr 2005 13:04:25 +0200
From: Pavel Machek <pavel@suse.cz>
To: Nathan Scott <nathans@sgi.com>
Cc: "Barry K. Nathan" <barryn@pobox.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, hare@suse.de, linux-xfs@oss.sgi.com
Subject: Re: [xfs-masters] swsusp vs. xfs [was Re: 2.6.12-rc2-mm1]
Message-ID: <20050412110425.GA3063@elf.ucw.cz>
References: <20050408103327.GD1392@elf.ucw.cz> <20050410211808.GA12118@ip68-4-98-123.oc.oc.cox.net> <20050410212747.GB26316@elf.ucw.cz> <20050410225708.GB12118@ip68-4-98-123.oc.oc.cox.net> <20050410230053.GD12794@elf.ucw.cz> <20050411043124.GA24626@ip68-4-98-123.oc.oc.cox.net> <20050411105759.GB1373@elf.ucw.cz> <20050411231213.GD702@frodo> <20050411235110.GA2472@elf.ucw.cz> <20050412002603.GA1178@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050412002603.GA1178@frodo>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I should take some sleep now, so I can't test the patch, but I don't
> > think it will help. If someone has PF_FREEZE set, he should be in
> > refrigerator.
> 
> OK, so if that doesn't help, here's an alternate approach - this
> lets xfsbufd track when its entering the refrigerator(), so that
> other callers know that attempts to wake it are futile.

Thanks, this patch helped.

								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
