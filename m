Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932310AbWGEH7K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932310AbWGEH7K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 03:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932378AbWGEH7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 03:59:10 -0400
Received: from smtp-103-wednesday.noc.nerim.net ([62.4.17.103]:2320 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S932310AbWGEH7J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 03:59:09 -0400
Date: Wed, 5 Jul 2006 09:59:06 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Pavel Machek <pavel@suse.cz>
Cc: Henrique de Moraes Holschuh <hmh@debian.org>,
       Michael Hanselmann <linux-kernel@hansmi.ch>,
       hdaps-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       lm-sensors@lm-sensors.org, Stelian Pop <stelian@popies.net>,
       vojtech@suse.cz
Subject: Re: [lm-sensors] Generic interface for accelerometers (AMS, HDAPS,
 ...)
Message-Id: <20060705095906.bf61fef8.khali@linux-fr.org>
In-Reply-To: <20060704235717.GD11872@elf.ucw.cz>
References: <20060703124823.GA18821@khazad-dum.debian.net>
	<20060704075950.GA13073@elf.ucw.cz>
	<20060704162346.GE9447@khazad-dum.debian.net>
	<20060704235717.GD11872@elf.ucw.cz>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Does this conversation really need to happen on 3 different mailing
lists at once?)

> > 3. Control of accelerometer parameters:
> >    3a. Report of accelerometer type (hdaps, ams, etc) and other metadata
> >        (name, location, what it is measuring (system accel, hd-bay 
> >        accel...))
> 
> Well, if your system is accelerating at different speed than hd-bay,
> then your machine is either _way_ too big, or you are in bad trouble.

Not necessarily. If the system is spinning, each point has its own
acceleration vector. Having two accelerometers in a system would be a
convenient way to detect that kind of movement, and I wouldn't be
surprised to see it happen.

-- 
Jean Delvare
