Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316909AbSFVVeN>; Sat, 22 Jun 2002 17:34:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316912AbSFVVeM>; Sat, 22 Jun 2002 17:34:12 -0400
Received: from [213.4.129.129] ([213.4.129.129]:37614 "EHLO tsmtp2.mail.isp")
	by vger.kernel.org with ESMTP id <S316909AbSFVVeM>;
	Sat, 22 Jun 2002 17:34:12 -0400
Date: Sat, 22 Jun 2002 23:35:58 +0200
From: Diego Calleja <diegocg@teleline.es>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: piggy broken in 2.5.24 build
Message-Id: <20020622233558.441f7905.diegocg@teleline.es>
In-Reply-To: <Pine.LNX.4.44.0206221557330.7338-100000@chaos.physics.uiowa.edu>
References: <20020622225229.46805a91.diegocg@teleline.es>
	<Pine.LNX.4.44.0206221557330.7338-100000@chaos.physics.uiowa.edu>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Jun 2002 16:08:45 -0500 (CDT)
Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de> escribió:

> Now, if you "make" again, all files which include/linux/modversions.h
> need to be rebuilt, since it changed. And that's a lot of files, as
> you've noticed. The problem is that in reality, only a file which also
> *uses* one of these exported symbols really changes. But make cannot
> know that, so it recompiles everything which is possibly affected.


This has a lot of sense ;), thanks
