Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262866AbTHURj0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 13:39:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262880AbTHURjR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 13:39:17 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:25304 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S262872AbTHURis
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 13:38:48 -0400
Date: Thu, 21 Aug 2003 19:31:49 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Vinay K Nallamothu <vinay-rc@naturesoft.net>
Cc: linux-atm-general@lists.sourceforge.net, netdev@oss.sgi.com,
       Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.0-test3-bk8][ATM] fix ambassador.c
Message-ID: <20030821193149.A18920@electric-eye.fr.zoreil.com>
References: <1061478906.1069.23.camel@lima.royalchallenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1061478906.1069.23.camel@lima.royalchallenge.com>; from vinay-rc@naturesoft.net on Thu, Aug 21, 2003 at 08:45:05PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vinay K Nallamothu <vinay-rc@naturesoft.net> :
[...]
> drivers/atm/ambassador.c: 
> This patch cleans up sti/cli usage as well as minor timer cleanups.
[...]

The "dont_panic" function which uses cli/sti is only called from code
belonging to a "#if 0" section since revision 1.1 according to bk.

Remove it, everybody should feel better.

--
Ueimor
