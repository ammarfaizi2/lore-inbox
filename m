Return-Path: <linux-kernel-owner+w=401wt.eu-S1754695AbWLRW13@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754695AbWLRW13 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 17:27:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754697AbWLRW12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 17:27:28 -0500
Received: from exo3753.pck.nerim.net ([213.41.240.142]:18727 "EHLO
	mail-out1.exosec.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754695AbWLRW12 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 17:27:28 -0500
X-Greylist: delayed 786 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 Dec 2006 17:27:27 EST
Date: Mon, 18 Dec 2006 23:14:18 +0100
From: Willy Tarreau <wtarreau@exosec.fr>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Marcelo Tosatti <mtosatti@redhat.com>,
       Grant Coady <grant_lkml@dodo.com.au>
Subject: Re: Linux 2.4.34-rc3 / Linux 2.4.33.6
Message-ID: <20061218221418.GB19835@exosec.fr>
References: <20061218084133.GA13867@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20061218084133.GA13867@hera.kernel.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, Dec 18, 2006 at 08:41:33AM +0000, Willy Tarreau wrote:
> Hi,
> 
> Two changes before -final. The first one fixes a race where
> one can hit a BUG(), the second one fixes CVE-2006-4814.
> 
> -final is just a few days ahead (it scares me, I'll have to check
> my scripts to ensure everything's OK). If you have important fixes
> you want to see in, or if it does not work for you, please
> manifest yourself.


OK, it seems that the mirroring system on kernel.org is under load,
because the files have not been mirrored yet after about 15 hours.
Even the .bz2/.sign have not been produced.

As a TEMPORARY workaround for the (very few but brave) testers, I've
put the kernels here (both 2.4.34-rc3 and 2.4.33.6) :

      http://linux.exosec.net/kernel/2.4/

It has a small pipe, but I don't expect to see many downloads anyway.
There are NO signatures on those files, so believe what you want after
the test results.

Cheers,
Willy



--
EXOSEC - ZAC des Metz - 3 Rue du petit robinson - 78350 JOUY EN JOSAS
N°Indigo: 0 825 075 510 - Accueil: +33 1 72 89 72 30 - Fax: +33 1 72 89 80 19
Site web : http://www.exosec.fr/

