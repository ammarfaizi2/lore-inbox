Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751049AbWIHTKK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049AbWIHTKK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 15:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751072AbWIHTKK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 15:10:10 -0400
Received: from quechua.inka.de ([193.197.184.2]:14560 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S1751049AbWIHTKI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 15:10:08 -0400
Date: Fri, 8 Sep 2006 21:10:04 +0200
From: Bernd Eckenfels <be-mail2006@lina.inka.de>
To: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: patch to make Linux capabilities into something useful (v 0.3.1)
Message-ID: <20060908191004.GA15106@lina.inka.de>
References: <20060907173449.GA24013@clipper.ens.fr> <E1GLPhz-0001T9-00@calista.eckenfels.net> <20060907230028.GB30916@elf.ucw.cz> <20060908012201.GA14280@lina.inka.de> <20060908143946.GD17680@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060908143946.GD17680@elf.ucw.cz>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2006 at 04:39:47PM +0200, Pavel Machek wrote:
> Well, then mistake was running that daemon with elevated priviledges
> in the first place.

there are workers out there which expect to be started priveldged, do
something (bind, suid, ...) and then drop priveledges. If those check if the
drop is needed based on the euid...

Of course this can be solved better, however i remeber that those cases are
the ones where compatibility means any priveledge -> euid = 0.

Anyway, I think there is something like that in the proposed patch, so it
looks good.

Gruss
Bernd
-- 
  (OO)     -- Bernd_Eckenfels@Mörscher_Strasse_8.76185Karlsruhe.de --
 ( .. )    ecki@{inka.de,linux.de,debian.org}  http://www.eckes.org/
  o--o   1024D/E383CD7E  eckes@IRCNet  v:+497211603874  f:+49721151516129
(O____O)  When cryptography is outlawed, bayl bhgynjf jvyy unir cevinpl!
