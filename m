Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263559AbTH1Qet (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 12:34:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263590AbTH1Qet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 12:34:49 -0400
Received: from oceanic.wsisiz.edu.pl ([213.135.44.33]:23592 "EHLO
	oceanic.wsisiz.edu.pl") by vger.kernel.org with ESMTP
	id S263559AbTH1Qes (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 12:34:48 -0400
Date: Thu, 28 Aug 2003 18:34:45 +0200
From: Lukasz Trabinski <lukasz@oceanic.wsisiz.edu.pl>
To: chas williams <chas@cmf.nrl.navy.mil>
Cc: linux-kernel@vger.kernel.org, linux-atm-general@lists.sourceforge.net,
       solarz@wsisiz.edu.pl
Subject: [lukasz@wsisiz.edu.pl: Re: [Linux-ATM-General] Re: linux-2.4.22 Oops on ATM PCA-200EPC]
Message-ID: <20030828163445.GA32095@oceanic.wsisiz.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Aug 2003, chas williams wrote:
> 
> yep, i screwed that up.  when clip isnt a module, the common code try
> to manipulate the module count while fails.  see if this patch makes
> it better -- apply with patch -p1 in your linux source tree.

I have appled this patch, atm interfaces was created without any Ooops. 
Unfortunately, atm interfaces exists (with ip address), i can ping them 
localy but no any traffic goes through them. I can't ping remote atm 
inteface. ATM card is Fore LE155 (nicstar). 2.4.21-rc6 works well.

-- 
*[ £ukasz Tr±biñski ]*
SysAdmin @wsisiz.edu.pl
