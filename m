Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030264AbWBNAdE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030264AbWBNAdE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 19:33:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030304AbWBNAdE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 19:33:04 -0500
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:12302 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S1030264AbWBNAdC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 19:33:02 -0500
To: "D. Hazelton" <dhazelton@enter.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
References: <Pine.LNX.4.61.0601251523330.31234@yvahk01.tjqt.qr>
	<43F0891E.nailKUSCGC52G@burner> <871wy6sy7y.fsf@hades.wkstn.nix>
	<200602131903.08327.dhazelton@enter.net>
From: Nix <nix@esperi.org.uk>
X-Emacs: if it payed rent for disk space, you'd be rich.
Date: Tue, 14 Feb 2006 00:32:49 +0000
In-Reply-To: <200602131903.08327.dhazelton@enter.net> (D. Hazelton's message
 of "Mon, 13 Feb 2006 19:03:07 -0500")
Message-ID: <87oe1ard8u.fsf@hades.wkstn.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Feb 2006, D. Hazelton whispered secretively:
> On Monday 13 February 2006 17:14, Nix wrote:
>> (I doubt libscg would ever be interested in the stuff in most of the
>> other directories: things like /dev/mem are not SCSI devices and never
>> will be, and /sys/class/scsi_device contains *everything* Linux
>> considers a SCSI device, no matter what transport it is on, SATA and
>> all. However, I don't know if it handles IDE devices that you can SG_IO
>> to because I don't have any such here. Anyone know?)
> 
> Not on my system, and I have a DVD-ROM and a CDRW drive attached, both of 
> which are capable of SG_IO.

Blast. Well, all these SCSI-like things *should* appear in one place
in /sys, dammit. Even if they don't right now. :/

-- 
`... follow the bouncing internment camps.' --- Peter da Silva
