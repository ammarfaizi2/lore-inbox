Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161181AbWAHLJW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161181AbWAHLJW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 06:09:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161185AbWAHLJW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 06:09:22 -0500
Received: from quechua.inka.de ([193.197.184.2]:659 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S1161181AbWAHLJV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 06:09:21 -0500
Date: Sun, 8 Jan 2006 12:09:19 +0100
From: Bernd Eckenfels <be-mail2006@lina.inka.de>
Cc: Willy Tarreau <willy@w.ods.org>, linux-kernel@vger.kernel.org,
       gcoady@gmail.com
Subject: Re: Why is 2.4.32 four times faster than 2.6.14.6??
Message-ID: <20060108110919.GA6865@lina.inka.de>
References: <20060108095741.GH7142@w.ods.org> <E1EvXi5-0000kv-00@calista.inka.de> <20060108105401.GI7142@w.ods.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060108105401.GI7142@w.ods.org>
User-Agent: Mutt/1.5.9i
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 08, 2006 at 11:54:01AM +0100, Willy Tarreau wrote:
> > it eats it in high interrupt load.
> *high* ? he never goes far beyond 1000/s !

it is 10 times higher on 2.6 than 2.4 (I dont think this can be explained
by the timer, only.)

> quite possibly, but I'd rather think it's more precisely related
> to the ping-pong in the scheduler between grep, cut and ssh.

Could be, that would also send smaller buffers to tcp...

Gruss
Bernd
-- 
  (OO)     -- Bernd_Eckenfels@Mörscher_Strasse_8.76185Karlsruhe.de --
 ( .. )    ecki@{inka.de,linux.de,debian.org}  http://www.eckes.org/
  o--o   1024D/E383CD7E  eckes@IRCNet  v:+497211603874  f:+49721151516129
(O____O)  When cryptography is outlawed, bayl bhgynjf jvyy unir cevinpl!
