Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318473AbSIKH7X>; Wed, 11 Sep 2002 03:59:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318497AbSIKH7X>; Wed, 11 Sep 2002 03:59:23 -0400
Received: from neckar.ipht-jena.de ([194.94.32.118]:5124 "EHLO
	diamond.ipht-jena.de") by vger.kernel.org with ESMTP
	id <S318473AbSIKH7W>; Wed, 11 Sep 2002 03:59:22 -0400
Date: Wed, 11 Sep 2002 10:04:06 +0200
From: Axel Siebenwirth <axel@hh59.org>
To: Thomas Molina <tmolina@cox.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5 Problem Status Report
Message-ID: <20020911080406.GA231@diamond.ipht-jena.de>
Mail-Followup-To: Thomas Molina <tmolina@cox.net>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0209102057340.944-100000@dad.molina>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209102057340.944-100000@dad.molina>
User-Agent: Mutt/1.4i
Organization: hh59.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas!

On Tue, 10 Sep 2002, Thomas Molina wrote:

> The most current version of this status report can be found at:
> http://members.cox.net/tmolina/kernprobs/status.html

>               2.5 Kernel Problem Reports as of 10 Sep
>    Problem Title                Status                Discussion
>    JFS oops                     open                  06 Sep 2002

We have now figured out what causes this. It only happens when the kernel is
compiled with CONFIG_PREEMPT enabled. Without CONFIG_PREEMPT JFS runs just
prefectly.
This preemption stuff seems to cause a lot of trouble.

http://marc.theaimsgroup.com/?l=linux-kernel&m=103127160424684&w=2

Best regards,
Axel Siebenwirth
