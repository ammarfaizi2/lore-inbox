Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932266AbWAUBxA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932266AbWAUBxA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 20:53:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932296AbWAUBxA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 20:53:00 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:49852 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932266AbWAUBw7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 20:52:59 -0500
Subject: Re: [2.6 patch] the scheduled removal of the obsolete raw driver
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       "'Andrew Morton'" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Badari Pulavarty <pbadari@us.ibm.com>
In-Reply-To: <20060121010229.GP31803@stusta.de>
References: <20060118194103.5c569040.akpm@osdl.org>
	 <200601190543.k0J5hBg06542@unix-os.sc.intel.com>
	 <20060121010229.GP31803@stusta.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 21 Jan 2006 01:49:17 +0000
Message-Id: <1137808158.24161.64.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2006-01-21 at 02:02 +0100, Adrian Bunk wrote:
> Why did noone tell me anythong about such issues although I'm the one 
> listed as having this driver deprecated?

Because they don't spend their lives tracking the base kernel, they
expect sanity to prevail and their idea of an obsolescence cycle is
about five years.

ISV = "Independant software vendor"

Obsoleting stuff which is distribution internal configuration type stuff
(eg devfs->udev) is one thing but core syscall related stuff has to
undergo a much much longer cycle, or in many cases you just have to look
at it and treat it as a lesson for the future and a thing to tackle in
whatever OS obsoletes Linux.

Thats why 0.98.5 libc 2.2 and rogue still work on 2.6.

Alan

