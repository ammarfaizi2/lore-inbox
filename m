Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265476AbUFCCk0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265476AbUFCCk0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 22:40:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265474AbUFCCk0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 22:40:26 -0400
Received: from mail011.syd.optusnet.com.au ([211.29.132.65]:1423 "EHLO
	mail011.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S265467AbUFCCkP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 22:40:15 -0400
From: Stuart Young <cef-lkml@optusnet.com.au>
To: linux-kernel@vger.kernel.org, root@chaos.analogic.com
Subject: Re: Problem with ioremap which returns NULL in 2.6 kernel
Date: Thu, 3 Jun 2004 12:41:27 +1000
User-Agent: KMail/1.6.2
Cc: Markus Lidel <Markus.Lidel@shadowconnect.com>,
       Jeff Garzik <jgarzik@pobox.com>
References: <40BC788A.3020103@shadowconnect.com> <40BDF1AC.7070209@shadowconnect.com> <Pine.LNX.4.53.0406021144280.559@chaos>
In-Reply-To: <Pine.LNX.4.53.0406021144280.559@chaos>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406031241.27669.cef-lkml@optusnet.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jun 2004 01:45, Richard B. Johnson wrote:
> I asked for the output of `cat /proc/pci` . Unless I get that
> information, I can't find the length of the allocation.

Is there no way to to get this information out of lspci (eg: lspci -vv)? This 
is particularly annoying since /proc/pci is depreciated. I know a number of 
people who simply don't bother turning it on anymore. If there is information 
in /proc/pci that isn't available through lspci somehow, then I'd call that a 
nasty regression, which needs to be fixed.

Are you sure on this Richard? (No disrespect intended, just want to confirm 
things).

-- 
 Stuart Young (aka Cef)
 cef-lkml@optusnet.com.au is for LKML and related email only
