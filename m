Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262051AbTKGWmZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 17:42:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262052AbTKGW0Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 17:26:24 -0500
Received: from jurand.ds.pg.gda.pl ([153.19.208.2]:19922 "EHLO
	jurand.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S264095AbTKGL5G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 06:57:06 -0500
Date: Fri, 7 Nov 2003 12:57:01 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.6] Don't disable IOAPIC with nosmp
In-Reply-To: <Pine.LNX.4.53.0311051856320.6825@montezuma.fsmlabs.com>
Message-ID: <Pine.LNX.4.32.0311071237410.5945-100000@jurand.ds.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Nov 2003, Zwane Mwaikambo wrote:

> This patch addresses bugzilla bug#1487
> http://bugme.osdl.org/show_bug.cgi?id=1487
>
> We're disabling the IOAPIC when someone boots with the nosmp kernel
> parameter, this happens to break interrupt routing for some folks.

 I object -- that's a feature.  Use "maxcpus=1" instead of "nosmp" or
"maxcpus=0" (which is an equivalent) to keep APICs enabled with a single
CPU running.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

