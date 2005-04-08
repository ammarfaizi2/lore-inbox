Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262722AbVDHHTq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262722AbVDHHTq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 03:19:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262724AbVDHHTp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 03:19:45 -0400
Received: from smtp.istop.com ([66.11.167.126]:49803 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S262722AbVDHHTn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 03:19:43 -0400
From: Daniel Phillips <phillips@istop.com>
To: Rogan Dawes <rogan@dawes.za.net>
Subject: Re: Kernel SCM saga..
Date: Fri, 8 Apr 2005 03:21:02 -0400
User-Agent: KMail/1.7
Cc: "H. Peter Anvin" <hpa@zytor.com>, cw@f00f.org,
       linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org> <d353vk$72m$1@terminus.zytor.com> <42562D47.9080705@dawes.za.net>
In-Reply-To: <42562D47.9080705@dawes.za.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504080321.02462.phillips@istop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 08 April 2005 03:05, Rogan Dawes wrote:
> Take a look at
> http://www.linuxshowcase.org/2001/full_papers/ezolt/ezolt_html/
>
> Abstract
>
> GNU libc's default setting for malloc can cause a significant
> performance penalty for applications that use it extensively, such as
> Compaq's high performance extended math library, CXML.  The default
> malloc tuning can cause a significant number of minor page faults, and
> result in application performance of only half of the true potential.

This does not smell like an n*2 suckage, more like n^something suckage.  
Finding the elephant under the rug should not be hard.  Profile?

Regards,

Daniel
