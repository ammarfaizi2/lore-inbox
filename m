Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261963AbULVNdY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261963AbULVNdY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 08:33:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261986AbULVNdX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 08:33:23 -0500
Received: from mx01.cybersurf.com ([209.197.145.104]:40152 "EHLO
	mx01.cybersurf.com") by vger.kernel.org with ESMTP id S261963AbULVNdV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 08:33:21 -0500
Subject: Re: Lockup with 2.6.9-ac15 related to netconsole
From: jamal <hadi@cyberus.ca>
Reply-To: hadi@cyberus.ca
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: Patrick McHardy <kaber@trash.net>, Matt Mackall <mpm@selenic.com>,
       Mark Broadbent <markb@wetlettuce.com>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
In-Reply-To: <20041222123940.GA4241@electric-eye.fr.zoreil.com>
References: <20041221002218.GA1487@electric-eye.fr.zoreil.com>
	 <20041221005521.GD5974@waste.org>
	 <52121.192.102.214.6.1103624620.squirrel@webmail.wetlettuce.com>
	 <20041221123727.GA13606@electric-eye.fr.zoreil.com>
	 <49295.192.102.214.6.1103635762.squirrel@webmail.wetlettuce.com>
	 <20041221204853.GA20869@electric-eye.fr.zoreil.com>
	 <20041221212737.GK5974@waste.org>
	 <20041221225831.GA20910@electric-eye.fr.zoreil.com>
	 <41C93FAB.9090708@trash.net> <41C9525F.4070805@trash.net>
	 <20041222123940.GA4241@electric-eye.fr.zoreil.com>
Content-Type: text/plain
Organization: jamalopolous
Message-Id: <1103722395.1090.77.camel@jzny.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 22 Dec 2004 08:33:15 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-12-22 at 07:39, Francois Romieu wrote:

> If I am not mistaken, a failure on spin_trylock + the test on
> xmit_lock_owner imply that it is safe to directly handle the
> queue. It means that qdisc_run() has been interrupted on the
> current cpu and the other paths seem fine as well. Counter-example
> is welcome (no joke).

Think more than 2 processors ;-> 

cheers,
jamal

