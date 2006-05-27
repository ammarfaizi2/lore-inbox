Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751456AbWE0KSn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751456AbWE0KSn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 06:18:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751033AbWE0KSn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 06:18:43 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:28811 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750740AbWE0KSm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 06:18:42 -0400
Date: Sat, 27 May 2006 12:15:59 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Jeff Garzik <jeff@garzik.org>
cc: Git Mailing List <git@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [SCRIPT] chomp: trim trailing whitespace
In-Reply-To: <4477B905.9090806@garzik.org>
Message-ID: <Pine.LNX.4.61.0605271212210.6670@yvahk01.tjqt.qr>
References: <4477B905.9090806@garzik.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Attached to this email is chomp.pl, a Perl script which removes trailing
> whitespace from several files.  I've had this for years, as trailing whitespace
> is one of my pet peeves.
>
> Now that git-applymbox complains loudly whenever a patch adds trailing
> whitespace, I figured this script may be useful to others.
>

Pretty long script. How about this two-liner? It does not show 'bytes 
chomped' but it also trims trailing whitespace.

#!/usr/bin/perl -i -p
s/[ \t\r\n]+$//



Jan Engelhardt
-- 
