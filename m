Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263176AbVBCPek@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263176AbVBCPek (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 10:34:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262650AbVBCPbq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 10:31:46 -0500
Received: from gockel.physik3.uni-rostock.de ([139.30.44.16]:4762 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S262641AbVBCPbf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 10:31:35 -0500
Date: Thu, 3 Feb 2005 16:31:30 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Pankaj Agarwal <pankaj@toughguy.net>
cc: linux-kernel@vger.kernel.org, Linux Net <linux-net@vger.kernel.org>
Subject: Re: Query - Regarding strange behaviour.
In-Reply-To: <001501c509ff$d4be02e0$8d00150a@dreammac>
Message-ID: <Pine.LNX.4.53.0502031630290.4228@gockel.physik3.uni-rostock.de>
References: <001501c509ff$d4be02e0$8d00150a@dreammac>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Feb 2005, Pankaj Agarwal wrote:

> In my system there's a strange behaviour.... its not allowing me to create 
> any file in /usr/bin even as root. Its chmod is set to 755. Its even not 
> allowing me to change the chmod value of /usr/bin. The strangest part which 
> i felt is ...its shows the owner and group as root when i issue command 
> "ls -ld /usr/bin" and not allowing root to create any file or directory 
> under /usr/bin and not even allowing to change the chmod value. The error is 
> access permission denied... I can change the chmod value of /usr and other 
> directories under /usr/...but not of bin....

Maybe /usr is mounted read-only?
