Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263646AbUEGPyd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263646AbUEGPyd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 11:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263644AbUEGPyd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 11:54:33 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:30670 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S263656AbUEGPxc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 11:53:32 -0400
Date: Fri, 7 May 2004 16:53:17 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Pavel Machek <pavel@ucw.cz>
cc: Andrew Morton <akpm@osdl.org>, Paul Jackson <pj@sgi.com>,
       <vonbrand@inf.utfsm.cl>, <nickpiggin@yahoo.com.au>, <jgarzik@pobox.com>,
       <brettspamacct@fastclick.com>, <linux-kernel@vger.kernel.org>
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
In-Reply-To: <20040506130846.GA241@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44.0405071652280.15067-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 May 2004, Pavel Machek wrote:
> 
> Perhaps what we really want is "swap_back_in" script? That way you
> could do "updatedb; swap_back_in" in cron and be happy.

swapoff -a; swapon -a

Hugh

