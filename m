Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261260AbUL1VXt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261260AbUL1VXt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 16:23:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261262AbUL1VXs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 16:23:48 -0500
Received: from tabit.netstar.se ([195.178.179.33]:21970 "HELO tabit.netstar.se")
	by vger.kernel.org with SMTP id S261260AbUL1VXk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 16:23:40 -0500
Subject: Re: 2.6.10: e100 network broken after swsusp/resume
From: =?ISO-8859-1?Q?H=E5kan?= Lindqvist <lindqvist@netstar.se>
To: linux-kernel@vger.kernel.org
In-Reply-To: <20041228144741.GA2969@butterfly.hjsoft.com>
References: <20041228144741.GA2969@butterfly.hjsoft.com>
Content-Type: text/plain; charset=ISO-8859-15
Date: Tue, 28 Dec 2004 22:25:25 +0100
Message-Id: <1104269125.21123.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On tis, 2004-12-28 at 09:47 -0500, John M Flinchbaugh wrote:
> similarly to other people reports of hardware troubles after swsusp, my
> thinkpad r40's e100 nic doesn't fully function after resume.
> 
> ifplugd can see the link status change when i plug and unplug the cable,
> but the dhclient it runs just tries and retries to get an ip without
> success.


I seem to get the same problem on my IBM Thinkpad X31.

At least e100 and snd-intel8x0 break down that way on suspend/resume.
(http://marc.theaimsgroup.com/?l=linux-kernel&m=110419612421765&w=2)


/Håkan

