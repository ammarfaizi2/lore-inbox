Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263152AbTFPAag (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 20:30:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263163AbTFPAag
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 20:30:36 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:31709 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S263152AbTFPAag (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 20:30:36 -0400
Date: Mon, 16 Jun 2003 02:44:06 +0200 (MEST)
Message-Id: <200306160044.h5G0i6Su026505@harpo.it.uu.se>
From: mikpe@csd.uu.se
To: hyoshiok@miraclelinux.com
Subject: Re: [Perfctr-devel] perfctr-2.5.5 released
Cc: linux-kernel@vger.kernel.org, perfctr-devel@lists.sourceforge.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(I missed the cc: list)

On Mon, 16 Jun 2003 09:18:46 +0900, Hiro Yoshioka wrote:
> I just download perfctr 2.5.5 and see the difference
> between 2.5.4 and 2.5.5 but I could not find code
> changes except the changelog and todo.
> 
> $ diff -u perfctr-2.5.4 perfctr-2.5.5
> diff -u perfctr-2.5.4/CHANGES perfctr-2.5.5/CHANGES
> --- perfctr-2.5.4/CHANGES       2003-06-01 21:32:45.000000000 +0900
> +++ perfctr-2.5.5/CHANGES       2003-06-16 07:11:23.000000000 +0900

Missing '-r' option to diff, so it only diffs the toplevel files.
Use diff -ruN to compare two directories recursively.

/Mikael
