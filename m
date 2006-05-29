Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751110AbWE2QAR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751110AbWE2QAR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 12:00:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751126AbWE2QAQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 12:00:16 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:29413 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751110AbWE2QAP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 12:00:15 -0400
Subject: Re: How to check if kernel sources are installed on a system?
From: Arjan van de Ven <arjan@infradead.org>
To: Christopher Friesen <cfriesen@nortel.com>
Cc: 4Front Technologies <dev@opensound.com>, linux-kernel@vger.kernel.org,
       bidulock@openss7.org, Lee Revell <rlrevell@joe-job.com>,
       Heiko Carstens <heiko.carstens@de.ibm.com>
In-Reply-To: <447B18DB.3030805@nortel.com>
References: <e55715+usls@eGroups.com> <1148596163.31038.30.camel@mindpipe>
	 <1148653797.3579.18.camel@laptopd505.fenrus.org>
	 <20060528130320.GA10385@osiris.ibm.com>
	 <1148835799.3074.41.camel@laptopd505.fenrus.org>
	 <1148838738.21094.65.camel@mindpipe>
	 <1148839964.3074.52.camel@laptopd505.fenrus.org>
	 <1148846131.27461.14.camel@mindpipe>  <20060528224402.A13279@openss7.org>
	 <1148878368.3291.40.camel@laptopd505.fenrus.org>
	 <447A883C.5070604@opensound.com>
	 <1148883077.3291.47.camel@laptopd505.fenrus.org>
	 <447B18DB.3030805@nortel.com>
Content-Type: text/plain
Date: Mon, 29 May 2006 18:00:07 +0200
Message-Id: <1148918407.3291.93.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-05-29 at 09:52 -0600, Christopher Friesen wrote:
> Arjan van de Ven wrote:
> > On Sun, 2006-05-28 at 22:35 -0700, 4Front Technologies wrote:
> > 
> >>BTW, why is Mandriva the only distro to turn OFF REGPARM?. Again, I think 
> >>distros shouldn't be given an option to turn it off if its a good thing to have.
> 
> > why not? It's not like it's a dramatic change of API after all... (and
> > even if it were...)
> > 
> > external modules shouldn't care, they really really should inherit the
> > cflags from the kernel's makefiles at which point.. the thing is moot.
> 
> Speaking from personal experience...there are a LOT of 3rd party drivers 
> out there that do not build their modules properly. 

yup there are. sad but true ;(

>  It gets especially 
> interesting when they want to have a single package support 2.4 and 2.6, 
> and also link the result against an included binary blob.

well if a binary blob is involved you've lost already in many ways.


