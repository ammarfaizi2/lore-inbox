Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965084AbWFIKed@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965084AbWFIKed (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 06:34:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965083AbWFIKed
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 06:34:33 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:34948 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S965015AbWFIKec (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 06:34:32 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: Using netconsole for debugging suspend/resume
Date: Fri, 9 Jun 2006 12:34:50 +0200
User-Agent: KMail/1.9.3
Cc: Matt Mackall <mpm@selenic.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@vger.kernel.org
References: <44886381.9050506@goop.org> <200606082240.31473.rjw@sisk.pl> <4488D565.2020103@goop.org>
In-Reply-To: <4488D565.2020103@goop.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606091234.50874.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 09 June 2006 03:56, Jeremy Fitzhardinge wrote:
> Rafael J. Wysocki wrote:
> > Please try doing "echo 8 > /proc/sys/kernel/printk" before suspend.
> >   
> Um, why?  That would increase the amount of log output, but I don't see 
> how it would help with netconsole preventing suspend, or not being able 
> to see console messages on a blank screen after resume.

Ah, that's after resume.  Sorry for the noise. :-)

Rafael
