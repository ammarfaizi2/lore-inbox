Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964950AbWDDBT5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964950AbWDDBT5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 21:19:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964951AbWDDBT5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 21:19:57 -0400
Received: from morbo.e-centre.net ([66.154.82.3]:44769 "EHLO
	cubert.e-centre.net") by vger.kernel.org with ESMTP id S964950AbWDDBT4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 21:19:56 -0400
X-ASG-Debug-ID: 1144113594-7172-62-0
X-Barracuda-URL: http://10.3.1.19:8000/cgi-bin/mark.cgi
X-ASG-Orig-Subj: Re: + isdn4linux-siemens-gigaset-drivers-logging-usage.patch added
	to -mm tree
Subject: Re: + isdn4linux-siemens-gigaset-drivers-logging-usage.patch added
	to -mm tree
From: Arjan van de Ven <arjan@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: tilman@imap.cc, hjlipp@web.de, kkeil@suse.de
In-Reply-To: <200604040051.k340p0RI008205@shell0.pdx.osdl.net>
References: <200604040051.k340p0RI008205@shell0.pdx.osdl.net>
Content-Type: text/plain
Date: Tue, 04 Apr 2006 03:19:50 +0200
Message-Id: <1144113590.3067.4.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=4.0 tests=
X-Barracuda-Spam-Report: Code version 3.02, rules version 3.0.10447
	Rule breakdown below pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> -	struct semaphore sem;		/* locks this structure: */
> -					/*   connected is not changed, */
> -					/*   hardware_up is not changed, */
> -					/*   MState is not changed to or from
> -					     MS_LOCKED */
> +	struct semaphore sem;		/* locks this structure:
> +					 *   connected is not changed,
> +					 *   hardware_up is not changed,
> +					 *   MState is not changed to or from
> +					 *   MS_LOCKED */
>  


please consider turning this into a mutex 

