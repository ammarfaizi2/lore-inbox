Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264124AbTDJTJ6 (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 15:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264125AbTDJTJ6 (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 15:09:58 -0400
Received: from fmr06.intel.com ([134.134.136.7]:64250 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S264124AbTDJTJ5 convert rfc822-to-8bit 
	(for <rfc822;linux-kernel@vger.kernel.org>); Thu, 10 Apr 2003 15:09:57 -0400
Message-ID: <A46BBDB345A7D5118EC90002A5072C780BEBA768@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'Ruth Ivimey-Cook'" <Ruth.Ivimey-Cook@ivimey.org>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: kernel support for non-english user messages
Date: Thu, 10 Apr 2003 12:21:31 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> From: Ruth Ivimey-Cook [mailto:Ruth.Ivimey-Cook@ivimey.org]
>
> >This is _not_ like any i18n support.  The problem is that normal
> 
> Agreed. How about changing the way printk works, so that instead of
> combining the format string, it just "prints" its args:
> 
> printk("%s: name %p is %d\n", name, ptr, val);
> 
> results in the following in the kernel buffer:
> 
> "%s: name %p is %d\n", "stringval", 0x4790243, 44

Debugging a non-klogd enabled kernel would be a pain - alas, having some
preprocessing tool, this can be done without that modification. If you 
know the format string (from the sources), given a printed message, a 
regexp could extract the parts that need translation.

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own
(and my fault)
