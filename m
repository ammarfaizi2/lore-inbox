Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270228AbTHLMH0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 08:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270230AbTHLMH0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 08:07:26 -0400
Received: from hugin.diku.dk ([130.225.96.144]:38930 "HELO hugin.diku.dk")
	by vger.kernel.org with SMTP id S270228AbTHLMHX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 08:07:23 -0400
Date: Tue, 12 Aug 2003 14:07:20 +0200 (MEST)
From: "Peter \"Firefly\" Lund" <firefly@diku.dk>
To: Philip Brown <phil@bolthole.com>
cc: dri-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Dri-devel] Re: [PATCH] CodingStyle fixes for drm_agpsupport
In-Reply-To: <20030811120949.A9285@bolthole.com>
Message-ID: <Pine.LNX.4.55.0308121405210.16518@brok.diku.dk>
References: <E19mF4Y-0005Eg-00@tetrachloride> <20030811164012.GB858@work.bitmover.com>
 <3F37CB44.5000307@pobox.com> <20030811170425.GA4418@work.bitmover.com>
 <3F37CF4E.3010605@pobox.com> <20030811172333.GA4879@work.bitmover.com>
 <3F37D80D.5000703@pobox.com> <20030811175941.GB4879@work.bitmover.com>
 <20030811120949.A9285@bolthole.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Aug 2003, Philip Brown wrote:

>  if (!pointer) {
> 	return (whatever);
>  }
>
>
> because it's consistent, and guaranteed safe from stupid parsing errors
                                                    ^^^^^^^^^^^^^^^^^^^^^

return is /still/ not a function - so don't put in visual stuff that hints
that it is.

I can read it and understand it just fine -- if I slow down and think.
Don't make me think unless I absolutely have to.  It might distract me
from more important aspects of the code and it steals my time.

-Peter
