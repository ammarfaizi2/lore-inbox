Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262514AbUJ0Qmn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262514AbUJ0Qmn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 12:42:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262508AbUJ0Qiq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 12:38:46 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:32159 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262473AbUJ0QaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 12:30:19 -0400
Subject: Re: My thoughts on the "new development model"
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Bill Davidsen <davidsen@tmr.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200410260142_MC3-1-8D2A-45C2@compuserve.com>
References: <200410260142_MC3-1-8D2A-45C2@compuserve.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1098890835.4302.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 27 Oct 2004 16:27:16 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-10-26 at 06:40, Chuck Ebbert wrote:
>   - superio parports don't work
>   - TCP networking using TSO gives memory allocation failures
>   - s390 has a serious security bug (sacf)
>   - ppp hangup is broken with some peers
>   - exec leaks POSIX timer memory and loses signals

You missed the remote DoS attack 8(

>   - i8042 fails to initialize with some boards using legacy USB

This is really a BIOS issue and its not a new 2.6.9 bug its a long
standing and messy story.

