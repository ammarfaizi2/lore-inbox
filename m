Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264183AbTDJVJX (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 17:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264189AbTDJVJX (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 17:09:23 -0400
Received: from fmr01.intel.com ([192.55.52.18]:49907 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S264183AbTDJVJW convert rfc822-to-8bit (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 17:09:22 -0400
Message-ID: <A46BBDB345A7D5118EC90002A5072C780BEBA7DD@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'Chuck Ebbert'" <76306.1226@compuserve.com>,
       "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: RE: kernel support for non-english user messages
Date: Thu, 10 Apr 2003 14:20:54 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> From: Chuck Ebbert [mailto:76306.1226@compuserve.com]
>
> >>      How about changing the way printk works, so that instead of
> >> combining the format string, it just "prints" its args:
> >>
> >> printk("%s: name %p is %d\n", name, ptr, val);
> >>
> >> results in the following in the kernel buffer:
> >>
> >> "%s: name %p is %d\n", "stringval", 0x4790243, 44
> >
> > Debugging a non-klogd enabled kernel would be a pain
> 
> 
>  Why?  Shouldn't it be easy to fix dmesg so it unmangles the output?

s/non-klogd enabled/dmesg/

Same thing - what I mean is that if you don't have some automatic
means to recompose the messages, reading the direct output of 
the console (as sometimes you have to), becomes a mess.

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own
(and my fault)
