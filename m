Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945925AbWBONLo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945925AbWBONLo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 08:11:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945930AbWBONLo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 08:11:44 -0500
Received: from mo01.iij4u.or.jp ([210.130.0.20]:15084 "EHLO mo01.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S1945925AbWBONLn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 08:11:43 -0500
Date: Wed, 15 Feb 2006 22:11:35 +0900 (JST)
Message-Id: <20060215.221135.121135595.toriatama@inter7.jp>
To: paulkf@microgate.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: PPP with PCMCIA modem stalls on 2.6.10 or later
From: Kouji Toriatama <toriatama@inter7.jp>
In-Reply-To: <1139937159.3189.4.camel@amdx2.microgate.com>
References: <1139863919.3868.16.camel@amdx2.microgate.com>
	<20060215.005753.74732581.toriatama@inter7.jp>
	<1139937159.3189.4.camel@amdx2.microgate.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Fulghum <paulkf@microgate.com> wrote:
> In 2.6.10, a new check for errors on received characters was added.
> 
> Try the patch below. It prevents the check from discarding
> received frames, but outputs an error message to the syslog.
> 
> Run with the patch and return the results with
> any syslog output containing the error message.

I have tried your patch in 2.6.15.4, but the problem did not
change at all.  I have also tried the patch in 2.6.10, but
the result was the same.  I have got no error messages from
syslog and dmesg.

Are there any other tests I can do to pin down the problem?

Best regards,
Kouji Toriatama
