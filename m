Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267740AbUHUUGA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267740AbUHUUGA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 16:06:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267743AbUHUUF7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 16:05:59 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:38310 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267740AbUHUUFv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 16:05:51 -0400
Date: Sat, 21 Aug 2004 21:05:50 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Lei Yang <leiyang@nec-labs.com>
Cc: Sam Ravnborg <sam@ravnborg.org>,
       Kernel Newbies Mailing List <kernelnewbies@nl.linux.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Problems compiling kernel modules
Message-ID: <20040821200549.GA21964@parcelfarce.linux.theplanet.co.uk>
References: <4127A15C.1010905@nec-labs.com> <20040821214402.GA7266@mars.ravnborg.org> <4127A662.2090708@nec-labs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4127A662.2090708@nec-labs.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 21, 2004 at 03:45:38PM -0400, Lei Yang wrote:
> You mean I can't use stdio.h at all?

Not in the kernel code.
 
> But what if I really need to?

Then you are really out of luck.

> Is there anything I can do?

A lot of things - hopefully your life is not reduced to trying to write
stdio-dependent kernel modules...
