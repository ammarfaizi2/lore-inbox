Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932236AbWCMSGm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932236AbWCMSGm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 13:06:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932241AbWCMSGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 13:06:41 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:41660 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932236AbWCMSGk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 13:06:40 -0500
Subject: Re: Kernel config problem between 2.4.x to 2.6.x!
From: Lee Revell <rlrevell@joe-job.com>
To: j4K3xBl4sT3r <jakexblaster@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <436c596f0603130342u4d38445bt5e9f129349cda0c8@mail.gmail.com>
References: <436c596f0603121015j2a091ab2sf43d0c5c396bbb72@mail.gmail.com>
	 <7c3341450603121247n7afe018m@mail.gmail.com>
	 <436c596f0603121632qe3151k793fd3ccd9a0eacb@mail.gmail.com>
	 <200603130708.13685.nick@linicks.net>
	 <436c596f0603130342u4d38445bt5e9f129349cda0c8@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 13 Mar 2006 13:06:35 -0500
Message-Id: <1142273196.25358.317.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.92 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-03-13 at 08:42 -0300, j4K3xBl4sT3r wrote:
> 1. before, the mouse worked fine. now, it doesnt works

Probably /dev/input/mice vs. /dev/psaux isue

> 2. before, the sound worked. and now, still working, just with ALSA,
> no OSS support (tested with mpg321 and ogg123 on bash terminal) 


Best:
aoss ./oss-app

Not as good:
modprobe snd-pcm-oss
./oss-app

Lee

