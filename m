Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161061AbVLWVll@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161061AbVLWVll (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 16:41:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161063AbVLWVll
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 16:41:41 -0500
Received: from quechua.inka.de ([193.197.184.2]:3782 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S1161061AbVLWVlk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 16:41:40 -0500
Date: Fri, 23 Dec 2005 22:41:38 +0100
From: Bernd Eckenfels <be-mail2005@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: nfs insecure_locks / Tru64 behaviour
Message-ID: <20051223214138.GA25727@lina.inka.de>
References: <E1EprNK-0005ZC-00@calista.inka.de> <1135371520.8555.2.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1135371520.8555.2.camel@lade.trondhjem.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 23, 2005 at 09:58:40PM +0100, Trond Myklebust wrote:
> Huh? No it doesn't. The Linux NLM server requires that the client
> authenticate using AUTH_SYS (unless you use insecure_locks), but it
> certainly doesn't require you to have root privileges. That would
> violate POSIX locking rules.

Yes, however True64 does not authenticate (properly), thats why you need the
option if you want to do locking.

Gruss
Bernd
-- 
  (OO)     -- Bernd_Eckenfels@Mörscher_Strasse_8.76185Karlsruhe.de --
 ( .. )    ecki@{inka.de,linux.de,debian.org}  http://www.eckes.org/
  o--o   1024D/E383CD7E  eckes@IRCNet  v:+497211603874  f:+49721151516129
(O____O)  When cryptography is outlawed, bayl bhgynjf jvyy unir cevinpl!
