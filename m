Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964848AbWHHMvf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964848AbWHHMvf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 08:51:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964881AbWHHMvB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 08:51:01 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:43271 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S964848AbWHHMuZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 08:50:25 -0400
Date: Tue, 8 Aug 2006 12:10:02 +0000
From: Pavel Machek <pavel@suse.cz>
To: Shem Multinymous <multinymous@gmail.com>
Cc: Robert Love <rlove@rlove.org>, Jean Delvare <khali@linux-fr.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       hdaps-devel@lists.sourceforge.net
Subject: Re: [PATCH 07/12] hdaps: delay calibration to first hardware query
Message-ID: <20060808121001.GE4540@ucw.cz>
References: <11548492171301-git-send-email-multinymous@gmail.com> <11548492753662-git-send-email-multinymous@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11548492753662-git-send-email-multinymous@gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The hdaps driver currently calibrates its rest position upon
> initialization, which can take several seconds on first module load
> (and delays the boot process accordingly). This patch delays 
> calibration to the first successful hardware query, when the
> information is available anyway. Writes to the "calibrate" sysfs
> attribute are handled likewise.
> 
> Signed-off-by: Shem Multinymous <multinymous@gmail.com>

Looks ok.

Signed-off-by: Pavel Machek <pavel@suse.cz>



-- 
Thanks for all the (sleeping) penguins.
