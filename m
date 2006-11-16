Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423857AbWKPMiy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423857AbWKPMiy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 07:38:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423860AbWKPMiy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 07:38:54 -0500
Received: from main.gmane.org ([80.91.229.2]:6110 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1423857AbWKPMix (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 07:38:53 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Oleg Verych <olecom@flower.upol.cz>
Subject: Re: strange behaviour with x86_64
Date: Thu, 16 Nov 2006 12:38:25 +0000 (UTC)
Organization: Palacky University in Olomouc, experimental physics department.
Message-ID: <slrnelonbf.7lr.olecom@flower.upol.cz>
References: <200611151608.23992.cova@ferrara.linux.it>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: flower.upol.cz
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>, Oleg Verych <olecom@flower.upol.cz>
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006-11-15, Fabio Coatti wrote:
> Hi all,

I'm just trying to move things forward, i'm not a developer.

> I'm seeing a strange behaviour on a dual opteron machine (or, at least it seem 
> so to me) and I need some advice.
> The hardware is: dual opteron 2.4, dual core, 2GB ram
> This machine runs apache webserver/mod_perl. Due to some bug in perl code, 
> often the machine runs out of memory, and oomkiller triggers.

You seem to run very interesting distribution; when reporting
*kernel* bugs (things), try to follow REPORTING-BUGS (in top dir. of kernel
sources): version (ver_linux), adding to CC list memory management
list from MAINTAINERS file.

As for me, kernel in oom condition is very bad thing. I don't think
"oom killer" idea is working in general (while it helps to link
allyesconfig kernel on 1G without swap ;).

Thus, i suggest you to play with stuff, described in
"Documentation/vm/overcommit-accounting".
____

