Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964995AbWGIF2S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964995AbWGIF2S (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 01:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964996AbWGIF2S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 01:28:18 -0400
Received: from 142.163.233.220.exetel.com.au ([220.233.163.142]:25575 "EHLO
	idefix.homelinux.org") by vger.kernel.org with ESMTP
	id S964995AbWGIF2R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 01:28:17 -0400
Subject: Re: Suspend to RAM regression tracked down
From: Jean-Marc Valin <Jean-Marc.Valin@USherbrooke.ca>
To: Dave Jones <davej@redhat.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>, cpufreq@lists.linux.org.uk
In-Reply-To: <20060709032103.GA31395@redhat.com>
References: <1151837268.5358.10.camel@idefix.homelinux.org>
	 <44A80B20.1090702@goop.org> <1152271537.5163.4.camel@idefix.homelinux.org>
	 <20060707162152.GB3223@redhat.com>
	 <1152312530.14453.16.camel@idefix.homelinux.org>
	 <20060708062345.GB3356@redhat.com>
	 <1152399303.14453.29.camel@idefix.homelinux.org>
	 <20060709032103.GA31395@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: =?ISO-8859-1?Q?Universit=E9?= de Sherbrooke
Date: Sun, 09 Jul 2006 15:28:15 +1000
Message-Id: <1152422895.14453.32.camel@idefix.homelinux.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Actually, before deep diving into chasing bugs in ondemand, we should
> probably confirm that the same behaviour doesn't happen with a different
> governor.  Can you try that ?   Try setting it to userspace, and then
> running a userspace app like cpuspeed/powernowd etc.

Well, that's the thing here. I tried userspace and couldn't get it to
crash (for several weeks in a row). However, someone I know with the
same laptop model (not sure it's the exact same revision) told me it
would crash on him with userspace as well.

	Jean-Marc
