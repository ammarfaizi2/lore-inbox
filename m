Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262895AbTIACbi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 22:31:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262916AbTIACbi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 22:31:38 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:62104
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S262895AbTIACbh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 22:31:37 -0400
From: Con Kolivas <kernel@kolivas.org>
To: rzei@mbnet.fi, linux-kernel@vger.kernel.org
Subject: Re: O18.1int problems
Date: Mon, 1 Sep 2003 12:38:44 +1000
User-Agent: KMail/1.5.3
References: <200309010012.53716.rzei@mbnet.fi>
In-Reply-To: <200309010012.53716.rzei@mbnet.fi>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309011238.44733.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Sep 2003 07:12, Joonas Koivunen wrote:
> Hi,
>
> after reading some mails and discussion about Con Kolivas' patches I
> decided to give a try. Got latest (-test4) vanilla and applied
> patch-test4-O18.1int. Desktop (kde pre 3.2) runs smoother than with vanilla
> 2.6.0-test3.

Great thanks for feedback.

> But when I tried to recompile my kde sources (first updating from cvs)
> starting with rebuilding makefile templates (make -f Makefile.cvs) (some
> autoconf/automake stuff, don't really know :) it froze. In Konsole window I
> tried ctrl-c, ctrl-d, no effect. A brief ps aux | grep make shows that make
> is in D state and so is it's find task. This D state didn't clear in 24
> houres and I seem to be unable of reproducing it under vanilla 2.6.0-test4.
> Killing of those processes didn't work (though I'm not sure if it should
> kill those instantly).
>
> Is this problem with my configuration or some sneaky bug? System had been
> up some time (24-48 houres) so I'll try reproducing it later also.

Please look further into it for something else sneaky. There is nothing in the 
O1int patch logic that says put this state into D forever.

Cheers,
Con

