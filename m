Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318870AbSHWPzu>; Fri, 23 Aug 2002 11:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318869AbSHWPzu>; Fri, 23 Aug 2002 11:55:50 -0400
Received: from codepoet.org ([166.70.99.138]:37778 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S318870AbSHWPzs>;
	Fri, 23 Aug 2002 11:55:48 -0400
Date: Fri, 23 Aug 2002 09:59:59 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix bitops.h circular dependancies
Message-ID: <20020823155958.GA26060@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
References: <200208231046.g7NAk2914276@devserv.devel.redhat.com> <20020823145907.GA24609@codepoet.org> <20020823151615.GB24609@codepoet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020823151615.GB24609@codepoet.org>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.18-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Aug 23, 2002 at 09:16:15AM -0600, Erik wrote:
> On Fri Aug 23, 2002 at 08:59:08AM -0600, Erik wrote:
> > It appears that linux/bitops.h includes asm/bitops.h, which itself
> > includes linux/bitops.h prior to the #define fls(x)...  Both files
> > have include guards, therefore the #define never happens....
> 
> Here is a fix.  Not an ideal fix, but it at least works.

"You feel foolish.  Goodbye level 2."

I was fixing a patch I'd added locally...  Sorry about 
the noise,

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
