Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423534AbWJZOwa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423534AbWJZOwa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 10:52:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752119AbWJZOw3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 10:52:29 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:42176 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751698AbWJZOw3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 10:52:29 -0400
Subject: Re: incorrect taint of ndiswrapper
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, proski@gnu.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20061026144117.GI29920@ftp.linux.org.uk>
References: <1161807069.3441.33.camel@dv>
	 <1161808227.7615.0.camel@localhost.localdomain>
	 <20061025205923.828c620d.akpm@osdl.org>
	 <1161859199.12781.7.camel@localhost.localdomain>
	 <20061026144117.GI29920@ftp.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 26 Oct 2006 15:55:39 +0100
Message-Id: <1161874540.12781.58.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-10-26 am 15:41 +0100, ysgrifennodd Al Viro:
> Could we please decide WTF _GPLONLY *is* and at least remain consistent?
> Aside of "method of fighting binary-only modules", that is - this part
> is obvious.

It was originally added to mark symbols that are clearly internal only
and make a work derivative. It's somewhere expanded to include symbols
whose code authors think that a cease and desist is the correct answer
to non GPL use.

I can't really help personally on the details there since I'm of the
opinion that _GPLONLY while useful doesn't generally make a blind bit of
difference as most if not all binary modules are violating the license.
(And I'm sure Nvidia's legal counsel disagrees with me at least in
public)

Alan

