Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932484AbVIZTn4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932484AbVIZTn4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 15:43:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932485AbVIZTn4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 15:43:56 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:21204 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932484AbVIZTnz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 15:43:55 -0400
Subject: Re: Resource limits
From: Matthew Helsley <matthltc@us.ibm.com>
To: Al Boldi <a1426z@gawab.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       "Chandra S. Seetharaman" <sekharan@us.ibm.com>
In-Reply-To: <200509251712.42302.a1426z@gawab.com>
References: <200509251712.42302.a1426z@gawab.com>
Content-Type: text/plain
Date: Mon, 26 Sep 2005 12:07:01 -0700
Message-Id: <1127761622.12346.2017.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-09-25 at 17:12 +0300, Al Boldi wrote:
> Resource limits in Linux, when available, are currently very limited.
> 
> i.e.:
> Too many process forks and your system may crash.
> This can be capped with threads-max, but may lead you into a lock-out.
> 
> What is needed is a soft, hard, and a special emergency limit that would 
> allow you to use the resource for a limited time to circumvent a lock-out.
> 
> Would this be difficult to implement?
> 
> Thanks!
> 
> --
> Al

	Have you looked at Class-Based Kernel Resource Managment (CKRM)
(http://ckrm.sf.net) to see if it fits your needs? My initial thought is
that the CKRM numtasks controller may help limit forks in the way you
describe.

	If you have any questions about it please join the CKRM-Tech mailing
list (ckrm-tech@lists.sourceforge.net) or chat with folks on the OFTC
IRC #ckrm channel.

Cheers,
	-Matt Helsley

