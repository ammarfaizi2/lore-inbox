Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262121AbTIRUlK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 16:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262122AbTIRUlK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 16:41:10 -0400
Received: from [193.138.115.2] ([193.138.115.2]:19472 "HELO
	diftmgw.backbone.dif.dk") by vger.kernel.org with SMTP
	id S262121AbTIRUlH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 16:41:07 -0400
Date: Thu, 18 Sep 2003 22:39:42 +0200 (CEST)
From: Jesper Juhl <jju@dif.dk>
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: cherry@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: IA32 - 27 New warnings
In-Reply-To: <20030918084011.5ac7be61.rddunlap@osdl.org>
Message-ID: <Pine.LNX.4.56.0309182235460.10753@jju_lnx.backbone.dif.dk>
References: <200309180623.h8I6N3F4007504@cherrypit.pdx.osdl.net>
 <Pine.LNX.4.56.0309181518090.10528@jju_lnx.backbone.dif.dk>
 <20030918084011.5ac7be61.rddunlap@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 18 Sep 2003, Randy.Dunlap wrote:

> On Thu, 18 Sep 2003 15:33:21 +0200 (CEST) Jesper Juhl <jju@dif.dk> wrote:
>
> |
> | On Wed, 17 Sep 2003, John Cherry wrote:
> |
> | > drivers/ide/legacy/pdc4030.c:307: warning: `return' with no value, in function returning non-void
> | > drivers/ide/legacy/pdc4030.c:323: warning: control reaches end of non-void function
> |
> | Below is a patch that silences those two warnings and (hopefully) does the
> | right thing (I'll attempt to deal with the other ones later today).
> |
> | I've tried as best I could to work out the logic of what goes on in that
> | file, and I /think/ I got it right, but I don't have the hardware to test
> | if I broke something horribly, so someone more knowledgable than me is
> | needed to confirm the patch and preferably some brave soul with Promise
> | hardware to test it as well.
> |
> | A little explanation of why I do what I do in the patch:
>
> [snip]
>
> Bart (IDE maintainer) has already posted patches for this.
> See
> http://marc.theaimsgroup.com/?l=linux-kernel&m=106329427503487&w=2
>
So I see, and probably a lot better than what I managed to do (haven't
studied it in detail yet, but it looks a lot more comprehensive than my
little hack).
Ohh well, I had fun trying to sort out the problem and create a fix - now
I'm off looking for more resonably simple stuff to fix.  :)


Jesper Juhl <jju@dif.dk>
