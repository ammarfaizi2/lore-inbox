Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932564AbWBTCCK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932564AbWBTCCK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 21:02:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932581AbWBTCCK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 21:02:10 -0500
Received: from mx0.towertech.it ([213.215.222.73]:23173 "HELO mx0.towertech.it")
	by vger.kernel.org with SMTP id S932564AbWBTCCH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 21:02:07 -0500
Date: Mon, 20 Feb 2006 03:01:46 +0100
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: Adrian Bunk <bunk@stusta.de>
Cc: Martin Michlmayr <tbm@cyrius.com>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, John Bowler <jbowler@acm.org>
Subject: Re: [RFC] [PATCH 1/2] Driver to remember ethernet MAC values:
 maclist
Message-ID: <20060220030146.11f418dc@inspiron>
In-Reply-To: <20060220014735.GD4971@stusta.de>
References: <20060220010113.GA19309@deprecation.cyrius.com>
	<20060220014735.GD4971@stusta.de>
Organization: Tower Technologies
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Feb 2006 02:47:35 +0100
Adrian Bunk <bunk@stusta.de> wrote:

> > Some Ethernet hardware implementations have no built-in storage for
> > allocated MAC values - an example is the Intel IXP420 chip which has
> > support for Ethernet but no defined way of storing allocated MAC values.
> > With such hardware different board level implementations store the
> > allocated MAC (or MACs) in different ways.  Rather than put board level
> > c
> Silly question:
> 
> Why can't this be implemented in user space using the SIOCSIFHWADDR 
> ioctl?

 Because sometimes you need to have networking available
 well before userspace.

 (netconsole, root over nfs, ...)

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it

