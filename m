Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262007AbUEWKEg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262007AbUEWKEg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 06:04:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262008AbUEWKEg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 06:04:36 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:61628 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S262007AbUEWKEd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 06:04:33 -0400
Date: Sun, 23 May 2004 11:03:02 +0100
From: Dave Jones <davej@redhat.com>
To: Manuel Kasten <kasten.m@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [speedste-centrino] couldn't enable Enhanced SpeedStep
Message-ID: <20040523100302.GA18596@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Manuel Kasten <kasten.m@gmx.de>, linux-kernel@vger.kernel.org
References: <200405231126.11815.kasten.m@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405231126.11815.kasten.m@gmx.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 23, 2004 at 11:26:11AM +0200, Manuel Kasten wrote:
 > Hello,
 > 
 > speedstep-centrino won't load on my laptop running 2.6.6 :
 > 
 > $ cat /var/log/dmesg | grep speedstep
 > speedstep-centrino: found "Intel(R) Pentium(R) M processor 1500MHz": max
 > frequency: 1500000kHz
 > speedstep-centrino: couldn't enable Enhanced SpeedStep
 > 
 > Can anybody explain what's going on?

We poke a magic bit, and read it back to see if it stuck at the
value we poked it.  In your case it didn't for some reason.

/proc/cpuinfo please ?

		Dave

