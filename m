Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261784AbUKCRoy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261784AbUKCRoy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 12:44:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261792AbUKCRox
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 12:44:53 -0500
Received: from ns9.hostinglmi.net ([213.194.149.146]:41425 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S261784AbUKCRm1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 12:42:27 -0500
Date: Wed, 3 Nov 2004 18:44:59 +0100
From: DervishD <lkml@dervishd.net>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org,
       =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Subject: Re: is killing zombies possible w/o a reboot?
Message-ID: <20041103174459.GA23015@DervishD>
Mail-Followup-To: Gene Heskett <gene.heskett@verizon.net>,
	linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
References: <200411030751.39578.gene.heskett@verizon.net> <yw1xis8nhtst.fsf@ford.inprovide.com> <20041103152531.GA22610@DervishD> <200411031147.14179.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200411031147.14179.gene.heskett@verizon.net>
User-Agent: Mutt/1.4.2.1i
Organization: DervishD
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
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

    Hi Gene :)

 * Gene Heskett <gene.heskett@verizon.net> dixit:
> >    Or write a little program that just 'wait()'s for the specified
> >PID's. That is perfectly portable IMHO. But I must admit that the
> >preferred way should be killing the parent. 'init' will reap the
> >children after that.
> But what if there is no parent, since the system has already disposed 
> of it?

    Then the children are reparented to 'init' and 'init' gets rid of
them. That's the way UNIX behaves.

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.dervishd.net & http://www.pleyades.net/
