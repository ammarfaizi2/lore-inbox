Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965144AbWFIEE1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965144AbWFIEE1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 00:04:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965143AbWFIEEZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 00:04:25 -0400
Received: from gw.goop.org ([64.81.55.164]:8065 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S965139AbWFIEEW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 00:04:22 -0400
Message-ID: <4488D565.2020103@goop.org>
Date: Thu, 08 Jun 2006 18:56:53 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@sisk.pl>
CC: Matt Mackall <mpm@selenic.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@vger.kernel.org
Subject: Re: Using netconsole for debugging suspend/resume
References: <44886381.9050506@goop.org> <200606082240.31473.rjw@sisk.pl>
In-Reply-To: <200606082240.31473.rjw@sisk.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rafael J. Wysocki wrote:
> Please try doing "echo 8 > /proc/sys/kernel/printk" before suspend.
>   
Um, why?  That would increase the amount of log output, but I don't see 
how it would help with netconsole preventing suspend, or not being able 
to see console messages on a blank screen after resume.

    J

