Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422728AbWJLQSf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422728AbWJLQSf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 12:18:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932656AbWJLQSe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 12:18:34 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:54220 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932644AbWJLQSe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 12:18:34 -0400
Subject: Re: Userspace process may be able to DoS kernel
From: Lee Revell <rlrevell@joe-job.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: =?ISO-8859-1?Q?G=FCnther?= Starnberger <gst@sysfrog.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0610121810050.28908@yvahk01.tjqt.qr>
References: <474c7c2f0610110954y46b68a14q17b88a5e28ffe8d9@mail.gmail.com>
	 <1160668565.24931.33.camel@mindpipe>
	 <Pine.LNX.4.61.0610121810050.28908@yvahk01.tjqt.qr>
Content-Type: text/plain
Date: Thu, 12 Oct 2006 12:19:27 -0400
Message-Id: <1160669968.24931.38.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-10-12 at 18:10 +0200, Jan Engelhardt wrote:
> >> As most users who reported this problem are using Ubuntu,
> >> the problem may be related to one of the settings in Ubuntu's kernel
> >> config. The configuration of my kernel is also based on the Ubuntu
> >> kernel config. As I am not using the patched kernel by Ubuntu I hope
> >> that the LKML is the right place to report this issue. 
> >
> >IIRC Ubuntu is the only major distro that ships with CONFIG_PREEMPT=y.
> >Any difference if you disable it?
> 
> SUSE uses CONFIG_PREEMPT(?) Voluntary Preemption too.

CONFIG_PREEMPT_VOLUNTARY != CONFIG_PREEMPT

