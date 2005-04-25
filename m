Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262665AbVDYPu4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262665AbVDYPu4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 11:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262647AbVDYPss
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 11:48:48 -0400
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:44486 "EHLO
	mail-in-04.arcor-online.net") by vger.kernel.org with ESMTP
	id S262634AbVDYPsT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 11:48:19 -0400
From: "Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>" 
	<7eggert@gmx.de>
Subject: Re: Git-commits mailing list feed.
To: Matt Domsch <Matt_Domsch@dell.com>,
       "David A. Wheeler" <dwheeler@dwheeler.com>, Paul Jakma <paul@clubi.ie>,
       Linus Torvalds <torvalds@osdl.org>, Sean <seanlkml@sympatico.ca>,
       Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       David Woodhouse <dwmw2@infradead.org>, Jan Dittmer <jdittmer@ppp0.net>,
       Greg KH <greg@kroah.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Git Mailing List <git@vger.kernel.org>
Reply-To: 7eggert@gmx.de
Date: Mon, 25 Apr 2005 17:47:13 +0200
References: <3WtO4-5GW-5@gated-at.bofh.it> <3WtXG-5Nh-9@gated-at.bofh.it> <3WtXG-5Nh-7@gated-at.bofh.it> <3WwLT-848-13@gated-at.bofh.it> <3WxeV-5S-9@gated-at.bofh.it> <3WxHT-pv-1@gated-at.bofh.it> <3Wyb3-Sj-33@gated-at.bofh.it> <3WyDZ-1a6-7@gated-at.bofh.it> <3WYRN-5lJ-9@gated-at.bofh.it> <3X0gU-6u6-5@gated-at.bofh.it> <3X1G1-7ug-9@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <E1DQ5nn-0003au-QN@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Domsch <Matt_Domsch@dell.com> wrote:

> --------------
> sign

> gpg --armor --clearsign --detach-sign --default-key "${DEFAULT_KEY} -v -v -o -
> ${1} | \ ${CUTSIG} > ${1}.sign

Use quotes!

> exit 0

The exit code should reflect the status from gpg.
If gpg failed, you might also want to remove the .sign file.

-- 
Top 100 things you don't want the sysadmin to say:
37. What is all this I here about static charges destroying computers?

