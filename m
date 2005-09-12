Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750700AbVILLDj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbVILLDj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 07:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750728AbVILLDi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 07:03:38 -0400
Received: from ns9.hostinglmi.net ([213.194.149.146]:62414 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S1750700AbVILLDi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 07:03:38 -0400
Date: Mon, 12 Sep 2005 13:07:12 +0200
From: DervishD <lkml@dervishd.net>
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: Michael Clark <michael@metaparadigm.com>, Brad Tilley <rtilley@vt.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: Universal method to start a script at boot
Message-ID: <20050912110712.GA287@DervishD>
Mail-Followup-To: Denis Vlasenko <vda@ilport.com.ua>,
	Michael Clark <michael@metaparadigm.com>,
	Brad Tilley <rtilley@vt.edu>, linux-kernel@vger.kernel.org
References: <1126462329.4324737923c2d@wmtest.cc.vt.edu> <1126462467.43247403c2e1c@wmtest.cc.vt.edu> <43250150.20308@metaparadigm.com> <200509121249.40467.vda@ilport.com.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200509121249.40467.vda@ilport.com.ua>
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
> Awful. This codifies ages-old Unix traditional SysV-like init
> and its derivatives, which should be get rid of instead.

    I'm with you in this, in fact I use my own init system, but...

> daemontools are absolutely wonderful way of controlling daemons.

    How the heck you make sure that svscan starts the services in the
correct order? Does it run the services in /services in any
particular order or just in the order resulting for a simple
globbing? How you make sure the services are shut down in any
particular order?

    All this seems like requiring scripts to do the job (that is,
ensuring a particular order of startup/shutdown), while sysvinit
gets this info from filenames. Obviously, dictating the order using a
script is far more flexible than using filenames but it's not as
simple, and that cannot be seen in the comparisons D.J.B. does in the
homepage of daemontools (which, BTW, is the only source of
documentation, and a very poor one). LSB, on the other hand, is
better structured and although I don't like sysvinit at all, the
system is better documented. And I hate runlevels...

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736 | http://www.dervishd.net
http://www.pleyades.net & http://www.gotesdelluna.net
It's my PC and I'll cry if I want to...
