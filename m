Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264167AbTDJUqw (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 16:46:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264168AbTDJUqw (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 16:46:52 -0400
Received: from siaag1ad.compuserve.com ([149.174.40.6]:1230 "EHLO
	siaag1ad.compuserve.com") by vger.kernel.org with ESMTP
	id S264167AbTDJUqv (for <rfc822;linux-kernel@vger.kernel.org>); Thu, 10 Apr 2003 16:46:51 -0400
Date: Thu, 10 Apr 2003 16:54:53 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: RE: kernel support for non-english user messages
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200304101658_MC3-1-33DE-AB9F@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>      How about changing the way printk works, so that instead of
>> combining the format string, it just "prints" its args:
>> 
>> printk("%s: name %p is %d\n", name, ptr, val);
>> 
>> results in the following in the kernel buffer:
>> 
>> "%s: name %p is %d\n", "stringval", 0x4790243, 44
>
> Debugging a non-klogd enabled kernel would be a pain


 Why?  Shouldn't it be easy to fix dmesg so it unmangles the output?

 The real problem I see is that this approach doesn't make it any
easier to translate the messages.

  Maybe someone should just try to write a Babelfish-like thing that
takes English kernel-speak and translates it as best it can?  It would
at least be amusing to read the output. :)

--
 Chuck
 I am not a number!
