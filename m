Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261256AbVGZXcx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261256AbVGZXcx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 19:32:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262401AbVGZXXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 19:23:39 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:12611 "EHLO
	pd2mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S262399AbVGZXX2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 19:23:28 -0400
Date: Tue, 26 Jul 2005 17:23:18 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: problem while executing insmod
In-reply-to: <4ur7c-6k7-13@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <42E6C5E6.3070505@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <4ur7c-6k7-13@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

deepak jose wrote:
> sir/madam,
> 
> i written a module function similar to hello, world in C .i compiled
> it.but when i ,m loading the module i'm getting the error that "the
> kernel compiled is kernel 2.4.20 whereas i'm having 2.4.20-8".
> wat i have to do to load it properly without forcing it to load.
> did i have to change my kernel.
> please suggest me a solution without changing the kernel.

Are you compiling against the same kernel version that's actually 
running on the machine? 2.4.20-8 sounds like a Red Hat 9 kernel version 
(an out of date one, BTW), you cannot build modules against vanilla 
2.4.20 kernel sources and load them into the Red Hat 9 version.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

