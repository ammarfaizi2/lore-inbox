Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262913AbVAKWpE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262913AbVAKWpE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 17:45:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262882AbVAKWnF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 17:43:05 -0500
Received: from fw.osdl.org ([65.172.181.6]:65427 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262866AbVAKV3K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 16:29:10 -0500
Date: Tue, 11 Jan 2005 13:29:05 -0800
From: Chris Wright <chrisw@osdl.org>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Chris Wright <chrisw@osdl.org>,
       Steve Bergman <steve@rueb.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Proper procedure for reporting possible security vulnerabilities?
Message-ID: <20050111132905.N10567@build.pdx.osdl.net>
References: <41E2B181.3060009@rueb.com> <87d5wdhsxo.fsf@deneb.enyo.de> <41E2F6B3.9060008@rueb.com> <Pine.LNX.4.61.0501102309270.2987@dragon.hygekrogen.localhost> <20050110164001.Q469@build.pdx.osdl.net> <Pine.LNX.4.61.0501111758290.3368@dragon.hygekrogen.localhost> <1105461562.16168.46.camel@localhost.localdomain> <Pine.LNX.4.61.0501111854120.3368@dragon.hygekrogen.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.61.0501111854120.3368@dragon.hygekrogen.localhost>; from juhl-lkml@dif.dk on Tue, Jan 11, 2005 at 10:25:18PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jesper Juhl (juhl-lkml@dif.dk) wrote:
> 
> This thread got started by a question about how to go about informing 
> people about security vulnerabilities so I think we should erhaps try to 
> provide some sensible information about how to go about that that can be 
> useful to people no matter what "disclosure camp" the agree with. How 
> about something like what I've written below as an addition to 
> REPORTING-BUGS or as a seperate REPORTING-SECURITY-BUGS document ?

Let's just bite the bullet...

===== REPORTING-BUGS 1.2 vs edited =====
--- 1.2/REPORTING-BUGS	2002-02-04 23:39:13 -08:00
+++ edited/REPORTING-BUGS	2005-01-10 15:35:10 -08:00
@@ -16,6 +16,9 @@ code relevant to what you were doing. If
 describe how to recreate it. That is worth even more than the oops itself.
 The list of maintainers is in the MAINTAINERS file in this directory.
 
+      If it is a security bug, please copy the Security Contact listed
+in the MAINTAINERS file.  They can help coordinate bugfix and disclosure.
+
       If you are totally stumped as to whom to send the report, send it to
 linux-kernel@vger.kernel.org. (For more information on the linux-kernel
 mailing list see http://www.tux.org/lkml/).
===== MAINTAINERS 1.269 vs edited =====
--- 1.269/MAINTAINERS	2005-01-10 17:29:35 -08:00
+++ edited/MAINTAINERS	2005-01-11 13:29:23 -08:00
@@ -1959,6 +1959,11 @@ M:	christer@weinigel.se
 W:	http://www.weinigel.se
 S:	Supported
 
+SECURITY CONTACT
+P:	Security Officers
+M:	kernel-security@{osdl.org, vger.kernel.org, wherever}
+S:	Supported
+
 SELINUX SECURITY MODULE
 P:	Stephen Smalley
 M:	sds@epoch.ncsc.mil
