Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262071AbTJGKTp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 06:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262078AbTJGKTp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 06:19:45 -0400
Received: from b-195-adc53e.lohjanpuhelin.fi ([62.197.173.195]:53893 "EHLO
	mail.zmailer.org") by vger.kernel.org with ESMTP id S262071AbTJGKTo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 06:19:44 -0400
Date: Tue, 7 Oct 2003 06:19:35 -0400
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Vishwanath K C <kalbagil@india.hp.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: X server on asus board
Message-ID: <20031007101935.GT1305@mea-ext.zmailer.org>
References: <3F828749.BD9769A7@india.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F828749.BD9769A7@india.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 07, 2003 at 02:58:41PM +0530, Vishwanath K C wrote:
> Hi All,
> I am unable to install RH 8.0 X server on asus mother board.
> Do I need to install any specific drivers for that ?

Yes.

However the issue is with XFree86 server rather than with linux kernel.

Also, without knowing _what_ hardware does your motherboard have, e.g.
builtin AGP display controller, or some additional card in an AGP slot,
even XFree86 folks can't help you out.

The minimum data needed for it is   /sbin/lspci -v    output.

You just might have a display card that isn't supported by the XFree86;
yet...

> -vi

/Matti Aarnio
