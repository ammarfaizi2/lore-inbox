Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272692AbTHEMbW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 08:31:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272697AbTHEMbW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 08:31:22 -0400
Received: from mail.zmailer.org ([62.240.94.4]:26755 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id S272692AbTHEMbV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 08:31:21 -0400
Date: Tue, 5 Aug 2003 15:31:17 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: FINALLY caught a panic
Message-ID: <20030805123117.GT6898@mea-ext.zmailer.org>
References: <20030805122354.GL13456@rdlg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030805122354.GL13456@rdlg.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 05, 2003 at 08:23:54AM -0400, Robert L. Harris wrote:
> I've got a machine which has been dying repeatedly with nothing loged to
> the serial console we could see. 
.... 
> Can someone please tell me what this means or how to figure it out?  The

See FAQ at:   http://www.tux.org/lkml/#s4-3

Feeding that Oops to  ksymoops at your running machine _might_ help,
but if you use modules, it is somewhat less likely to succeed, as
module loading may end up at different memory locations.

Plain numeric Oops definitely does not help.

... 
> Thanks,
>   Robert

/Matti Aarnio
