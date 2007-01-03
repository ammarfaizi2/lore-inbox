Return-Path: <linux-kernel-owner+w=401wt.eu-S1750816AbXACOXt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750816AbXACOXt (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 09:23:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750819AbXACOXt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 09:23:49 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:54520 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750816AbXACOXs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 09:23:48 -0500
Date: Wed, 3 Jan 2007 14:28:39 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Grzegorz Kulewski <kangur@polcom.net>, Mikael Pettersson <mikpe@it.uu.se>,
       s0348365@sms.ed.ac.uk, torvalds@osdl.org, 76306.1226@compuserve.com,
       akpm@osdl.org, bunk@stusta.de, greg@kroah.com,
       linux-kernel@vger.kernel.org, yanmin_zhang@linux.intel.com
Subject: Re: kernel + gcc 4.1 = several problems
Message-ID: <20070103142839.311717f2@localhost.localdomain>
In-Reply-To: <1167831136.3095.8.camel@laptopd505.fenrus.org>
References: <200701030212.l032CDXe015365@harpo.it.uu.se>
	<20070103102944.09e81786@localhost.localdomain>
	<Pine.LNX.4.63.0701031128420.14187@alpha.polcom.net>
	<20070103124410.4cb191dd@localhost.localdomain>
	<1167831136.3095.8.camel@laptopd505.fenrus.org>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.10.4; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> cmov is effectively the same cost as a compare and jump, in both cases
> the cpu needs to do a prediction, and on a mispredict, restart.

On a P4 it appears to be slower than compare/jump in most cases

