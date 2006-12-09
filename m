Return-Path: <linux-kernel-owner+w=401wt.eu-S936877AbWLILTW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936877AbWLILTW (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 06:19:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936889AbWLILTW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 06:19:22 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:23311 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936877AbWLILTV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 06:19:21 -0500
Date: Sat, 9 Dec 2006 12:19:09 +0100 (MET)
From: Olaf Hering <olaf@aepfle.de>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Meelis Roos <mroos@linux.ee>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Judith Lebzelter <judith@osdl.org>
Subject: Re: PPC compiler error (redefinition of 'struct bug_entry')
Message-ID: <20061209111913.GA1854@aepfle.de>
References: <Pine.SOC.4.61.0612082059360.16172@math.ut.ee>
 <4579CD80.1040302@goop.org> <Pine.SOC.4.61.0612090728510.14163@math.ut.ee>
 <457A667E.5060608@goop.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <457A667E.5060608@goop.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, Jeremy Fitzhardinge wrote:

> So why don't I have arch/ppc/include/asm/bug.h in my tree here?

Most likely because you still do not build with 'make O=$somedir'.
