Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267097AbTA0LAM>; Mon, 27 Jan 2003 06:00:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267145AbTA0LAM>; Mon, 27 Jan 2003 06:00:12 -0500
Received: from ppp3290-cwdsl.fr.cw.net ([62.210.105.37]:41375 "EHLO
	bouton.inet6-interne.fr") by vger.kernel.org with ESMTP
	id <S267097AbTA0LAM>; Mon, 27 Jan 2003 06:00:12 -0500
Date: Mon, 27 Jan 2003 12:09:25 +0100
From: Lionel Bouton <Lionel.Bouton@inet6.fr>
To: rtilley <rtilley@vt.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Hard Disk Failure
Message-ID: <20030127120925.A9581@bouton.inet6-interne.fr>
Mail-Followup-To: rtilley <rtilley@vt.edu>, linux-kernel@vger.kernel.org
References: <3E3B3FF0@zathras>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3E3B3FF0@zathras>; from rtilley@vt.edu on dim, jan 26, 2003 at 09:33:11 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On dim, jan 26, 2003 at 09:33:11 -0500, rtilley wrote:
> Is it still possible for software to damage hardware in this fashion or is 
> hardware smarter now? Do drives know not to try and access a cylinder that is 
> outside their physical limits?
> 

I guess not :

Recently I moved one drive from one old system to a new one. The new BIOS
couldn't be configured to use the old geometry -> I couldn't use the drive
to boot (unless repartitioning the 120GiB beast).

During the migration process I tried different geometry settings and at
several times the cylinder number was way above the drive's actual limit.
I could hear loud "bumps" when the drive accessed the higher cylinders.
Each time I rushed to the reset button...

This was with a SiS735 chipset and a Maxtor 4G120J6.

LB.
