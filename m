Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261505AbUKCKHp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261505AbUKCKHp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 05:07:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261509AbUKCKHp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 05:07:45 -0500
Received: from deliver.epitech.net ([163.5.0.25]:63066 "HELO
	ideliver.epitech.net") by vger.kernel.org with SMTP id S261505AbUKCKHl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 05:07:41 -0500
Date: Wed, 3 Nov 2004 11:07:29 +0100
From: Marc Bevand <bevand_m@epita.fr>
To: dean gaudet <dean-list-linux-kernel@arctic.org>
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       linux-kernel@vger.kernel.org
Subject: Re: [rc4-amd64] RC4 optimized for AMD64
Message-ID: <20041103100729.GA4664@iah.epita.fr>
References: <cm4moc$c7t$1@sea.gmane.org> <Pine.LNX.4.61.0411011233203.8483@twinlark.arctic.org> <200411020854.21629.vda@port.imtp.ilyichevsk.odessa.ua> <Pine.LNX.4.61.0411021049510.6586@twinlark.arctic.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0411021049510.6586@twinlark.arctic.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dean gaudet wrote:
| 
| [...]
| you're asking about spending one byte?  one byte extra for code which 
| could perform better on more CPUs?

Guys, this does not matter _for now_, because AFAIK nobody has
benchmarked this code on an EM64T P4 CPU.

Obviously, if 'sub $1,X' is proved to be faster than 'dec' on the
Intel CPU, then I will change the code (since both instructions are
equivalent on AMD CPUs).

-- 
Marc Bevand                          http://www.epita.fr/~bevand_m
Computer Science School EPITA - System, Network and Security Dept.
