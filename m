Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263244AbTCYS1R>; Tue, 25 Mar 2003 13:27:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263245AbTCYS1Q>; Tue, 25 Mar 2003 13:27:16 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:20229
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S263244AbTCYS1I>; Tue, 25 Mar 2003 13:27:08 -0500
Subject: Re: Compiling options?
From: Robert Love <rml@tech9.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Robert L. Harris" <Robert.L.Harris@rdlg.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1048621636.28496.32.camel@irongate.swansea.linux.org.uk>
References: <20030325180334.GH15678@rdlg.net>
	 <1048621636.28496.32.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain
Organization: 
Message-Id: <1048617499.1486.334.camel@phantasy.awol.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 25 Mar 2003 13:38:19 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-03-25 at 14:47, Alan Cox wrote:

> If your boxes range from PII through to AMD duron build for 686, but the
> basic theory is the same.
> 
> A 386 kernel really hurts later CPUs
> A 486 kernel is generally fine
> A 686 kernel speeds stuff up a little more

Should add that a 586 kernel is horrid on 686 and Athlon machines - the
scheduling is worlds apart.  Use it only on true 586 machines.

If you need a common denominator, go with 486 as Alan pointed out.  In
your case 686 seems safe and sane, though.

	Robert Love

