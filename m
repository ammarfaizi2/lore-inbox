Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751264AbWH1Iak@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264AbWH1Iak (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 04:30:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751288AbWH1Iaj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 04:30:39 -0400
Received: from mtagate6.de.ibm.com ([195.212.29.155]:43676 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751264AbWH1Iai (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 04:30:38 -0400
Subject: Re: [PATCH 1/3] kthread: update s390 cmm driver to use kthread
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>,
       Christoph Hellwig <hch@infradead.org>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20060827185101.GA14976@sergelap.austin.ibm.com>
References: <20060824212241.GB30007@sergelap.austin.ibm.com>
	 <20060825143842.GA27364@infradead.org>
	 <20060825200359.GC13805@sergelap.austin.ibm.com>
	 <20060826063247.GA6928@osiris.boeblingen.de.ibm.com>
	 <20060827185101.GA14976@sergelap.austin.ibm.com>
Content-Type: text/plain
Organization: IBM Corporation
Date: Mon, 28 Aug 2006 10:30:33 +0200
Message-Id: <1156753833.15093.1.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-08-27 at 13:51 -0500, Serge E. Hallyn wrote:
> Hmm, with my standard config it actually boots.  It fails when I turn
> off module support.  The guilty config is attached, as well as the
> config that boots, and the output when it crashes with the guilty
> config.

That looks like the crypto initialization problem. Currently the new
crypto driver only works if you compile it as a module.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.


