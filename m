Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262139AbVEEPxg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262139AbVEEPxg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 11:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262142AbVEEPxg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 11:53:36 -0400
Received: from ojjektum.uhulinux.hu ([62.112.194.64]:51618 "EHLO
	ojjektum.uhulinux.hu") by vger.kernel.org with ESMTP
	id S262139AbVEEPxX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 11:53:23 -0400
Date: Thu, 5 May 2005 17:53:18 +0200
From: =?iso-8859-1?Q?Pozs=E1r_Bal=E1zs?= <pozsy@uhulinux.hu>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: /proc/ide/hd?/settings obsolete in 2.6.
Message-ID: <20050505155318.GD19927@ojjektum.uhulinux.hu>
References: <20050505004854.GA16550@animx.eu.org> <58cb370e050505031041c2c164@mail.gmail.com> <20050505111324.GA17223@animx.eu.org> <58cb370e050505051360d0588c@mail.gmail.com> <20050505153327.GA17724@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050505153327.GA17724@animx.eu.org>
User-Agent: Mutt/1.5.7i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 05, 2005 at 11:33:27AM -0400, Wakko Warner wrote:
> I am using edd to retrieve these parameters.  Unfortunately there are some
> utils that I use that I cannot give it the geometry.  Those utils depend on
> having the proper geometry so that the system can boot properly (no, it's
> not booting linux).
> 
> I need to work around what I can't fix otherwise.  So far, the proc entry is
> the only solution I have seen.

If those utils just open and read some files under /proc, you could 
always overmount those files or use some LD_PRELOAD magic.


-- 
pozsy
