Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932422AbVKAHgM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932422AbVKAHgM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 02:36:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932575AbVKAHgM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 02:36:12 -0500
Received: from ns1.suse.de ([195.135.220.2]:52419 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932422AbVKAHgL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 02:36:11 -0500
Date: Tue, 1 Nov 2005 08:35:55 +0100
From: Olaf Hering <olh@suse.de>
To: Mark Tomich <tomichm@bellsouth.net>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: patch to add a config option to enable SATA ATAPI by default
Message-ID: <20051101073555.GA11890@suse.de>
References: <1130691328.8303.8.camel@localhost> <20051031102723.GA10037@suse.de> <4365FF53.8000707@pobox.com> <1130810963.21921.4.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1130810963.21921.4.camel@localhost>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Mon, Oct 31, Mark Tomich wrote:

> Maybe I'm just not doing it properly, but I wasn't able to specify the
> "atapi_enabled" option on the kernel command line.  I tried it, but it
> still didn't see my  CD-ROM drive.  That's why I wrote the patch.

Use modulename.moduleoption=value, libata.atapi_enabled=1 will likely work.

-- 
short story of a lazy sysadmin:
 alias appserv=wotan
