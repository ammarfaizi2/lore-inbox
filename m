Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932135AbWIFFMz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932135AbWIFFMz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 01:12:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932182AbWIFFMz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 01:12:55 -0400
Received: from mail.gmx.net ([213.165.64.20]:27592 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932135AbWIFFMy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 01:12:54 -0400
X-Authenticated: #14349625
Subject: Re: bogofilter ate 3/5
From: Mike Galbraith <efault@gmx.de>
To: Zach Brown <zach.brown@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <44FE5019.6010404@oracle.com>
References: <20060905235732.29630.3950.sendpatchset@tetsuo.zabbo.net>
	 <44FE5019.6010404@oracle.com>
Content-Type: text/plain
Date: Wed, 06 Sep 2006 07:22:47 +0000
Message-Id: <1157527367.6199.9.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-09-05 at 21:35 -0700, Zach Brown wrote:
> What should I have done to avoid the spam regexes and what should I do
> now that I have a patch that makes them angry?

Use language similar to the naughty stuff that is getting through?

Seriously though, a quote from Matti's lkml announcement:

IF we take it into use, it will start rejecting messages
at SMTP input phase, so if it rejects legitimate message,
you should get a bounce from your email provider's system.
(Or from zeus.kernel.org, which is vger's backup MX.)

In such case, send the bounce with some explanations to 
<postmaster@vger.kernel.org> -- emails to that address
are explicitely excluded from all filtering!



