Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268286AbRHaQ5e>; Fri, 31 Aug 2001 12:57:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268217AbRHaQ5Z>; Fri, 31 Aug 2001 12:57:25 -0400
Received: from relay1.zonnet.nl ([62.58.50.37]:19891 "EHLO relay1.zonnet.nl")
	by vger.kernel.org with ESMTP id <S268145AbRHaQ5K>;
	Fri, 31 Aug 2001 12:57:10 -0400
Message-ID: <3B8FBB9F.F59A4772@linux-m68k.org>
Date: Fri, 31 Aug 2001 18:30:23 +0200
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: ptb@it.uc3m.es
CC: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
In-Reply-To: <200108311428.QAA13972@nbd.it.uc3m.es>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

"Peter T. Breuer" wrote:

> Hmm .. it looks like a model checker, and only for 1st order logic
> (i.e. not CTL). It seems very primitive. What's the point of using this
> instead of the many sphisticated model checkers and theorem provers out
> there?

We already have good experience with it. Feel free to try something
else, the more the better.
Nevertheless you have to define the bug and its context first. The
problem with defining some fancy min macro is you have too little
information about the context, so you can mostly only restrict the use
of min, possibly preventing legal uses of it (signed/unsigned compare is
AFAIK the only exception).

bye, Roman
