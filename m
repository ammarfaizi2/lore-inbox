Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263833AbTEFP3v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 11:29:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263837AbTEFP3v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 11:29:51 -0400
Received: from mailsrv1-tu0.sanger.ac.uk ([193.62.206.128]:25615 "EHLO
	mailsrv1.sanger.ac.uk") by vger.kernel.org with ESMTP
	id S263833AbTEFP3t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 11:29:49 -0400
Message-ID: <3EB7D7D9.2050603@thekelleys.org.uk>
Date: Tue, 06 May 2003 16:42:17 +0100
From: Simon Kelley <simon@thekelleys.org.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.2.1) Gecko/20030121
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "J. Bruce Fields" <bfields@fieldses.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Binary firmware in the kernel - licensing issues.
References: <3EB79ECE.4010709@thekelleys.org.uk> <20030506121954.GO24892@mea-ext.zmailer.org> <20030506151644.GA19898@fieldses.org>
In-Reply-To: <20030506151644.GA19898@fieldses.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J. Bruce Fields wrote:
> On Tue, May 06, 2003 at 03:19:54PM +0300, Matti Aarnio wrote:
> 
>
> 
> It's not Atmel whose permission you need to do this, it's the other
> kernel developers whose permission you need.  By releasing their code
> under the GPL, the people who hold copyright on all the other kernel
> code have essentially given you permission to modify and redistribute
> their code as long as you make source available for the resulting work.
> 
> The question is whether adding this binary blob to the linux kernel
> violates the license that the kernel developers gave you.  I can't see
> how Amtel saying it's OK would make it so.
> 
> --Bruce Fields

There are two issues. Atmel don't currently give me permission to
distribute their firmware so I need them to fix that. The keyspan 
wording is one way to do it.

Then, as you say, I need to know if the kernel developers have given
permission to distribute a work which combines Atmel's blob with
their source.[1]

If this was code which was linked into the kernel the answer would
clearly be no. Since it is not linked to the kernel, and doesn't
even run on the same processor as the kernel, the answer is not clear,
at least to me.

Maybe we need Linus to pronounce, or RMS. Existing practice has several
drivers with  firmware blobs[2]. What is the status of those? Am I
asking Questions Which Should Not Be Asked?


Simon.

[1] and though I'm not (yet) a holder of copyright on part of the Linux
kernel source, I do distribute other software under the GPL so these are
my rights we're talking about, too.

[2] Acenic, Advansys, Typhoon, Dgrs etc etc


