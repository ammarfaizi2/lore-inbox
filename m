Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276326AbRI1Vvc>; Fri, 28 Sep 2001 17:51:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276327AbRI1VvW>; Fri, 28 Sep 2001 17:51:22 -0400
Received: from mercury.rus.uni-stuttgart.de ([129.69.1.226]:46855 "EHLO
	mercury.rus.uni-stuttgart.de") by vger.kernel.org with ESMTP
	id <S276326AbRI1VvI>; Fri, 28 Sep 2001 17:51:08 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: all files are executable in vfat
In-Reply-To: <Pine.LNX.4.33.0109251434040.21994-100000@terbidium.openservices.net>
From: Florian Weimer <Florian.Weimer@RUS.Uni-Stuttgart.DE>
Date: 28 Sep 2001 23:50:45 +0200
In-Reply-To: <Pine.LNX.4.33.0109251434040.21994-100000@terbidium.openservices.net> (Ignacio Vazquez-Abrams's message of "Tue, 25 Sep 2001 14:35:38 -0400 (EDT)")
Message-ID: <tgbsjvrnm2.fsf@mercury.rus.uni-stuttgart.de>
User-Agent: Gnus/5.090001 (Oort Gnus v0.01) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ignacio Vazquez-Abrams <ignacio@openservices.net> writes:

> > Don't know if you already did this with umask, but {umask dmask uid gid}
> > probably make sense as per-mountpoint options rather than VFAT-specific
> > ones.
> 
> Not for filesystems that store permission info, e.g., ext2,
> ISO9660+RockRidge, etc.

Sometimes I wish there was a uid/gid option for ext2, too.  (Doing
forensic analysis as root is a bit risky. ;-)

-- 
Florian Weimer 	                  Florian.Weimer@RUS.Uni-Stuttgart.DE
University of Stuttgart           http://cert.uni-stuttgart.de/
RUS-CERT                          +49-711-685-5973/fax +49-711-685-5898
