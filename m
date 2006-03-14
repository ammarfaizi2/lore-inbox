Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750862AbWCNBhU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750862AbWCNBhU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 20:37:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752009AbWCNBhU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 20:37:20 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:52660 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750862AbWCNBhU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 20:37:20 -0500
Subject: Re: Kernel config problem between 2.4.x to 2.6.x!
From: Lee Revell <rlrevell@joe-job.com>
To: j4K3xBl4sT3r <jakexblaster@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <436c596f0603131731w172bb28cr43eec5e5bb32bf25@mail.gmail.com>
References: <436c596f0603121015j2a091ab2sf43d0c5c396bbb72@mail.gmail.com>
	 <7c3341450603121247n7afe018m@mail.gmail.com>
	 <436c596f0603121632qe3151k793fd3ccd9a0eacb@mail.gmail.com>
	 <200603130708.13685.nick@linicks.net>
	 <436c596f0603130342u4d38445bt5e9f129349cda0c8@mail.gmail.com>
	 <1142297572.7090.4.camel@shogun.daga.dyndns.org>
	 <436c596f0603131731w172bb28cr43eec5e5bb32bf25@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 13 Mar 2006 20:37:17 -0500
Message-Id: <1142300238.13256.80.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.92 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-03-13 at 22:31 -0300, j4K3xBl4sT3r wrote:
> doesnt matter executing the rc.udev, I run udevd and udevstart on my
> system. and doesnt work =S 

Did you read the "post Halloween document" describing changes from 2.4
to 2.6 or the LWN coverage of the 2.4->2.6 transition?  It's not
supposed to be a seamless upgrade...

udev must be working if ALSA works as it also depends on device nodes.

IIRC isapnptools is not needed if CONFIG_PNP is enabled.

Lee

