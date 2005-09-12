Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750812AbVILNKy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750812AbVILNKy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 09:10:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750815AbVILNKy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 09:10:54 -0400
Received: from ns9.hostinglmi.net ([213.194.149.146]:10379 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S1750812AbVILNKx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 09:10:53 -0400
Date: Mon, 12 Sep 2005 15:14:37 +0200
From: DervishD <lkml@dervishd.net>
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: Michael Clark <michael@metaparadigm.com>, Brad Tilley <rtilley@vt.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: Universal method to start a script at boot
Message-ID: <20050912131437.GA327@DervishD>
Mail-Followup-To: Denis Vlasenko <vda@ilport.com.ua>,
	Michael Clark <michael@metaparadigm.com>,
	Brad Tilley <rtilley@vt.edu>, linux-kernel@vger.kernel.org
References: <1126462329.4324737923c2d@wmtest.cc.vt.edu> <200509121249.40467.vda@ilport.com.ua> <20050912110712.GA287@DervishD> <200509121414.31884.vda@ilport.com.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200509121414.31884.vda@ilport.com.ua>
User-Agent: Mutt/1.4.2.1i
Organization: DervishD
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ns9.hostinglmi.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - dervishd.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Denis :)

 * Denis Vlasenko <vda@ilport.com.ua> dixit:
> >     How the heck you make sure that svscan starts the services in the
> > correct order?
> Simple. Usually I do not, because many of them do not
> depend on each other. In cases where I must, I code it
> in the script.

    OK, that's what I supposed. For small systems I usually prefer
the sysvinit approach for ordering, anyway.

> >     All this seems like requiring scripts to do the job (that is,
> > ensuring a particular order of startup/shutdown), while sysvinit
> > gets this info from filenames. Obviously, dictating the order using a
> > script is far more flexible than using filenames but it's not as
> > simple, and that cannot be seen in the comparisons D.J.B. does in the
> > homepage of daemontools (which, BTW, is the only source of
> > documentation, and a very poor one). LSB, on the other hand, is
> djb is crazy genius, what did you expect ;)

    Yes ;))))

> There is GPLed replacement of daemontools at http://smarden.org/runit/

    I know it, too, but I thought it was *based* on daemontools. I'll
take a look at it. Anyway, my init clone is compatible (more or less)
with both init.d and daemontools.
 
    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736 | http://www.dervishd.net
http://www.pleyades.net & http://www.gotesdelluna.net
It's my PC and I'll cry if I want to...
