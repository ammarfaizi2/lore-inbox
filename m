Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261790AbTEHP4u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 11:56:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261798AbTEHP4u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 11:56:50 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:2708 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261790AbTEHP4r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 11:56:47 -0400
Date: Thu, 8 May 2003 18:09:15 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Binary firmware in the kernel - licensing issues.
Message-ID: <20030508160915.GA12050@wohnheim.fh-wedel.de>
References: <200305081559.h48FxqF07117@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200305081559.h48FxqF07117@adam.yggdrasil.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 May 2003 08:59:52 -0700, Adam J. Richter wrote:
> Jörn Engel wrote:
> >For the kernel or the main CPU, the driver firmware is just data. The
> >same, as the magic 0x12345678ul that gets written to some register
> >because [can't tell, NDA]. In both cases, magic data gets written
> >somewhere and afterwards, things just work.
> 
> 	I think you are confusing "the preferred form of the work
> for making modifications to it" (the GPL's definition of "source
> code") with "documentation."  In the case of poking a few values,
> the preferred form for making modifications may be actually editing
> the numbers directly in source code.  That quite likely is the way
> that all developers maintain and modify that code, even if doing so
> in an effective manner requires additional documentation.
> 
> 	In comparison, with the binary blobs of firmware, the preferred
> form of the work for making modifications is, presumably, to edit
> a source file from which the binary blob can be rebuilt using an
> assembler or compiler.

What's the difference? If the code uses 0x12345670ul, but 0x12345678ul
would be correct, who is going to find the correct change without the
documentation. Maybe someone reverse engineering the meaning of those
bits. But most just accept the fact that one is better than the other
without understanding why.

And one big binary blob is better than the other. Same here.

Anyway, _should be ok_ is not _definitely legal in all countries_, so
we basically both say "see a lawyer".

Jörn

-- 
"Translations are and will always be problematic. They inflict violence 
upon two languages." (translation from German)
