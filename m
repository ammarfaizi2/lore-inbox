Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262403AbTIOA2Z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 20:28:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262405AbTIOA2Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 20:28:25 -0400
Received: from tench.street-vision.com ([212.18.235.100]:12441 "EHLO
	tench.street-vision.com") by vger.kernel.org with ESMTP
	id S262403AbTIOA2Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 20:28:24 -0400
Subject: Re: freed_symbols [Re: People, not GPL [was: Re: Driver Model]]
From: Justin Cormack <justin@street-vision.com>
To: hps@intermeta.de
Cc: Kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <bk30d3$ftu$1@tangens.hometree.net>
References: <20030914043716.GA19223@codepoet.org>
	<Pine.LNX.4.10.10309132152510.16744-100000@master.linux-ide.org> 
	<bk30d3$ftu$1@tangens.hometree.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-11) 
Date: 15 Sep 2003 01:27:49 +0100
Message-Id: <1063585669.3099.120.camel@lotte.street-vision.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-09-15 at 01:16, Henning P. Schmiedehausen wrote:
> Andre Hedrick <andre@linux-ide.org> writes:
> 
> 
> >It is coming and the intent is to return all the stolen symbols.
> >It is free for anyone to use and enjoy the usage of Linux once again.
> >So everyone get in line and SUE ME for GPL'ed drivers.
> 
> [... module code that would re-export GPL-marked symbols as non-GPL-marked snipped ...]
> 
> Well,
> 
> generally speaking, you're of course right. You're simply using the
> loophole of Linus' agreement to binary only modules to use a fully
> GPL'ed module (which might use the _GPL symbols), then consider the
> aggregation to be under GPL (IMHO correct) and then consider this
> aggregation of kernel and your module to be still covered by Linus'
> agreement (don't know whether this is true. You might want to actually
> ask Linus himself... ;-) )

actually (not that I was following the thread too closely) I thought the
GPL point in the dispute came down to the fact that as the kernel is
under GPL, you can change the export_symbols anywhere you like (under
the GPL) so you can export anything to a binary module.

To really enforce export to GPL only would be simple, you have the file
that exports symbols not under the GPL (and probably the loader to
really enforce it). Writing the license for that file/file loader
combination would be hard but maybe doable...



