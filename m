Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751145AbVL3FxQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751145AbVL3FxQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 00:53:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbVL3FxQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 00:53:16 -0500
Received: from smtp109.sbc.mail.mud.yahoo.com ([68.142.198.208]:33721 "HELO
	smtp109.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751145AbVL3FxP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 00:53:15 -0500
Message-ID: <43B4CB42.7050603@triplehelix.org>
Date: Thu, 29 Dec 2005 21:53:06 -0800
From: Joshua Kwan <joshk@triplehelix.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
Newsgroups: gmane.linux.kernel
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [vma list corruption] Re: proc_pid_readlink oopses again on 
  2.6.14.5
References: <dot96e$e76$1@sea.gmane.org>	 <20051228065354.GE27946@ftp.linux.org.uk> <1135758794.2935.3.camel@laptopd505.fenrus.org>
In-Reply-To: <1135758794.2935.3.camel@laptopd505.fenrus.org>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gentlemen,

On 12/28/2005 12:33 AM, Arjan van de Ven wrote:
>>So you've got 0xb7c1fc20 as vma.  Which is not good, since that's a userland
>>address.
> 
> 
> sounds like it may also be a good idea to check for rootkits; some of
> those try to muck with the vma chains and stuff.... and break if the
> kernel changes a bit.

I rebuilt the SAME kernel source (2.6.14.5) with gcc-3.3, and everything
works fine.

Still rootkit, GCC's problem, or what?

Thanks.

-- 
Joshua Kwan
