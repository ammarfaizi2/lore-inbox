Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267131AbTGGQC4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 12:02:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267134AbTGGQC4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 12:02:56 -0400
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:33809 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id S267131AbTGGQCz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 12:02:55 -0400
Date: Mon, 7 Jul 2003 07:04:52 +0200
From: Jurriaan <thunder7@xs4all.nl>
To: Midian <midian@ihme.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] Missing files in 2.5.74<
Message-ID: <20030707050452.GB1792@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
References: <1057528492.15569.8.camel@midux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1057528492.15569.8.camel@midux>
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Midian <midian@ihme.org>
Date: Mon, Jul 07, 2003 at 12:54:52AM +0300
> Hello,
> 
> I've tryed to compile the 2.5.74 kernel with pm2fb support, and never
> got it working I get this error message:
>   
>     CC [M]  drivers/video/pm2fb.o
> drivers/video/pm2fb.c:44:25: video/fbcon.h: No such file or directory

This means this framebuffer driver hasn't been ported to the new API and
won't compile, as you noticed.

Kind regards,
Jurriaan
-- 
Cole's Law:
  Thinly sliced cabbage.
Debian (Unstable) GNU/Linux 2.5.74 4112 bogomips load av: 0.89 0.57 0.27
