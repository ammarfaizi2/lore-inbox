Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161088AbWAHIAv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161088AbWAHIAv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 03:00:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161094AbWAHIAv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 03:00:51 -0500
Received: from quechua.inka.de ([193.197.184.2]:22406 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S1161088AbWAHIAv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 03:00:51 -0500
Date: Sun, 8 Jan 2006 09:00:48 +0100
From: Bernd Eckenfels <be-mail2006@lina.inka.de>
To: linux-kernel@vger.kernel.org
Cc: Grant Coady <gcoady@gmail.com>
Subject: Re: Why is 2.4.32 four times faster than 2.6.14.6??
Message-ID: <20060108080048.GA32737@lina.inka.de>
References: <d9def9db0601072258v39ac4334kccc843838b436bba@mail.gmail.com> <E1EvUp6-0008Ni-00@calista.inka.de> <irf1s1hdoqbsf9cin627gh9tgrsb51htoe@4ax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <irf1s1hdoqbsf9cin627gh9tgrsb51htoe@4ax.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 08, 2006 at 06:42:25PM +1100, Grant Coady wrote:
> Excuse me?  there is no 5 minutes wait time ;)

sure there is, you see the real time is 6mins vs 1min. since user and system
time are nearly the same, the delay is introduced by sleeping io. And if it
is not the disk, it is the terminal, as proofen by the redirection.

No the question is, if this is in the pty or tcp/networkstack code.

Gruss
Bernd
-- 
  (OO)     -- Bernd_Eckenfels@Mörscher_Strasse_8.76185Karlsruhe.de --
 ( .. )    ecki@{inka.de,linux.de,debian.org}  http://www.eckes.org/
  o--o   1024D/E383CD7E  eckes@IRCNet  v:+497211603874  f:+49721151516129
(O____O)  When cryptography is outlawed, bayl bhgynjf jvyy unir cevinpl!
