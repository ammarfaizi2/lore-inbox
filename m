Return-Path: <linux-kernel-owner+w=401wt.eu-S1425577AbWLHPsu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425577AbWLHPsu (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 10:48:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425580AbWLHPsu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 10:48:50 -0500
Received: from caffeine.uwaterloo.ca ([129.97.134.17]:52647 "EHLO
	caffeine.csclub.uwaterloo.ca" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1425577AbWLHPst (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 10:48:49 -0500
Date: Fri, 8 Dec 2006 10:48:48 -0500
To: Srivatsa Vaddagiri <vatsa@in.ibm.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: 64-bit app on 32-bit kernel supported?
Message-ID: <20061208154848.GA19987@csclub.uwaterloo.ca>
References: <20061208153606.GC11253@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061208153606.GC11253@in.ibm.com>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2006 at 09:06:06PM +0530, Srivatsa Vaddagiri wrote:
> Somebody was asking this : "Does any 32-bit Linux kernel support running 64-bit 
> app on top of it (in a 64-bit platform that is)?"
> 
> AFAIK its not supported, but wanted to make sure ..

You can run 32bit programs on many 64bit kernels, but a 32bit kernel
only runs 32bit code, since the code can't use 64bit features if the
kernel doesn't know about them and know how to context switch without
loosing the 64bit extensions.  As far as I know this is true of at least
x86, hppa (not sure 64bit is supported in linux since I never worked with
one), mips and sparc.

--
Len Sorensen
