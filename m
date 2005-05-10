Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261814AbVEJV33@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261814AbVEJV33 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 17:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261810AbVEJV32
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 17:29:28 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:63900 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261814AbVEJV3I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 17:29:08 -0400
Subject: Re: High res timer?
From: Lee Revell <rlrevell@joe-job.com>
To: Andre Eisenbach <int2str@gmail.com>
Cc: Matthias-Christian Ott <matthias.christian@tiscali.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <7f800d9f050510141626f70ee4@mail.gmail.com>
References: <7f800d9f050510132762f0ee7@mail.gmail.com>
	 <42811D51.1030106@tiscali.de>  <7f800d9f050510141626f70ee4@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 10 May 2005 17:29:01 -0400
Message-Id: <1115760541.14807.11.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-05-10 at 14:16 -0700, Andre Eisenbach wrote:
> 2005/5/10, Matthias-Christian Ott <matthias.christian@tiscali.de>:
> >
> > What about nanosleep ()?
> > 
> 
> nanosleep() seems to have some latency very similar to usleep(). Isn't
> usleep based on nanosleep()?
> 
> Here's what I get if I try to nanosleep for 5 secs (for testing):
> 
> -> 5.009952 s
> 
> The .009952 part varies, but is very close to that usually.

Is this a 2.4 kernel?  The resolution on 2.6 should be 1ms, not ~10ms.

Lee

