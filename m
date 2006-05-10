Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751244AbWEJTzV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244AbWEJTzV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 15:55:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751323AbWEJTzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 15:55:21 -0400
Received: from mcr-smtp-001.bulldogdsl.com ([212.158.248.7]:28676 "EHLO
	mcr-smtp-001.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S1751244AbWEJTzV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 15:55:21 -0400
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Daniel Walker <dwalker@mvista.com>
Subject: Re: [PATCH -mm] sys_semctl gcc 4.1 warning fix
Date: Wed, 10 May 2006 20:55:33 +0100
User-Agent: KMail/1.9.1
Cc: Al Viro <viro@ftp.linux.org.uk>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
References: <200605100256.k4A2u8bd031779@dwalker1.mvista.com> <20060510162106.GC27946@ftp.linux.org.uk> <1147279038.21536.120.camel@c-67-180-134-207.hsd1.ca.comcast.net>
In-Reply-To: <1147279038.21536.120.camel@c-67-180-134-207.hsd1.ca.comcast.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605102055.33593.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 10 May 2006 17:37, Daniel Walker wrote:
> On Wed, 2006-05-10 at 17:21 +0100, Al Viro wrote:
> > Don't.  Fix.  Correct.  Code.
> >
> > Ever.  Because sooner or later you will paper over real bug.  It's far
> > better to reject patches that just make $TOOL to STFU than risk blind
> > "fix" hiding a real bug.
>
> Couldn't agree with you more .. But I don't want to see the warning
> either ..

Maybe adding "#warning GCC false-positive in this file, line blah." would be a 
suitable compromise. "Seeing" the bug isn't that big a deal, it's opening the 
file up to investigate it only to find it's been investigated a million times 
before and the same conclusions drawn..

-- 
Cheers,
Alistair.

Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
