Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316503AbSHFXLI>; Tue, 6 Aug 2002 19:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316512AbSHFXLI>; Tue, 6 Aug 2002 19:11:08 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:26614 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S316503AbSHFXLH>; Tue, 6 Aug 2002 19:11:07 -0400
Date: Tue, 6 Aug 2002 19:14:46 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Marc-Christian Petersen <mcp@linux-systeme.de>, linux-aio@kvack.org,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: AIO together with SMPtimers-A0 oops and freezing
Message-ID: <20020806191446.E19564@redhat.com>
References: <200208051920.29018.mcp@linux-systeme.de> <20020806160724.A19564@redhat.com> <20020806223550.GC2733@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020806223550.GC2733@werewolf.able.es>; from jamagallon@able.es on Wed, Aug 07, 2002 at 12:35:50AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2002 at 12:35:50AM +0200, J.A. Magallon wrote:
> Hmm, I forgot to comment, but I apply smptimers on top of latest -aa, that
> includes aio (is it different implementation?), and the kernel works fine.

That would point to a merge error, or one of the changes that -aa made as 
being relevant.  Someone has to extract the differences to track it down.

		-ben
-- 
"You will be reincarnated as a toad; and you will be much happier."
