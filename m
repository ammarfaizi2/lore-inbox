Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290870AbSBFWqv>; Wed, 6 Feb 2002 17:46:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290858AbSBFWqn>; Wed, 6 Feb 2002 17:46:43 -0500
Received: from smtp1.vol.cz ([195.250.128.73]:2574 "EHLO smtp1.vol.cz")
	by vger.kernel.org with ESMTP id <S290860AbSBFWqX>;
	Wed, 6 Feb 2002 17:46:23 -0500
Date: Wed, 6 Feb 2002 14:22:59 +0000
From: Pavel Machek <pavel@suse.cz>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Asynchronous CDROM Events in Userland
Message-ID: <20020206142259.A37@toy.ucw.cz>
In-Reply-To: <Pine.LNX.4.30.0202032333200.1158-100000@rtlab.med.cornell.edu> <a3l4uc@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <a3l4uc@cesium.transmeta.com>; from hpa@zytor.com on Sun, Feb 03, 2002 at 09:07:24PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Rather than a signal, it should be a file descriptor of some sort, so
> one can select() etc on it.  Personally I can't imagine polling would
> take any appreciable amount of resources, though.

It may not eat CPU but it will definitely eat memory... Because polling
means deamon that normally could be swapped out needs to stay in memory.
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

