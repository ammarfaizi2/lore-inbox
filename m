Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261679AbUKCPeQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261679AbUKCPeQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 10:34:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261662AbUKCPXu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 10:23:50 -0500
Received: from ns9.hostinglmi.net ([213.194.149.146]:16311 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S261651AbUKCPXE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 10:23:04 -0500
Date: Wed, 3 Nov 2004 16:25:31 +0100
From: DervishD <lkml@dervishd.net>
To: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: is killing zombies possible w/o a reboot?
Message-ID: <20041103152531.GA22610@DervishD>
Mail-Followup-To: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>,
	linux-kernel@vger.kernel.org
References: <200411030751.39578.gene.heskett@verizon.net> <20041103143348.GA24596@outpost.ds9a.nl> <yw1xis8nhtst.fsf@ford.inprovide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yw1xis8nhtst.fsf@ford.inprovide.com>
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

    Hi all :)

 * Måns Rullgård <mru@inprovide.com> dixit:
> >> I'd tried to kill the zombie earlier but couldn't.
> >> Isn't there some way to clean up a &^$#^#@)_ zombie?
> > Kill the parent, is the only (portable) way.
> Perhaps not as portable, but another possible, though slightly
> complicated, way is to ptrace the parent and force it to wait().

    Or write a little program that just 'wait()'s for the specified
PID's. That is perfectly portable IMHO. But I must admit that the
preferred way should be killing the parent. 'init' will reap the
children after that.

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.dervishd.net & http://www.pleyades.net/
