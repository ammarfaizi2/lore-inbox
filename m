Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262148AbVEEQXK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262148AbVEEQXK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 12:23:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262146AbVEEQXJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 12:23:09 -0400
Received: from animx.eu.org ([216.98.75.249]:10635 "EHLO animx.eu.org")
	by vger.kernel.org with ESMTP id S262148AbVEEQVS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 12:21:18 -0400
Date: Thu, 5 May 2005 12:20:40 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: Pozs?r Bal?zs <pozsy@uhulinux.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: /proc/ide/hd?/settings obsolete in 2.6.
Message-ID: <20050505162040.GA17861@animx.eu.org>
Mail-Followup-To: Pozs?r Bal?zs <pozsy@uhulinux.hu>,
	linux-kernel@vger.kernel.org
References: <20050505004854.GA16550@animx.eu.org> <58cb370e050505031041c2c164@mail.gmail.com> <20050505111324.GA17223@animx.eu.org> <58cb370e050505051360d0588c@mail.gmail.com> <20050505153327.GA17724@animx.eu.org> <20050505155318.GD19927@ojjektum.uhulinux.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050505155318.GD19927@ojjektum.uhulinux.hu>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pozs?r Bal?zs wrote:
> On Thu, May 05, 2005 at 11:33:27AM -0400, Wakko Warner wrote:
> > I am using edd to retrieve these parameters.  Unfortunately there are some
> > utils that I use that I cannot give it the geometry.  Those utils depend on
> > having the proper geometry so that the system can boot properly (no, it's
> > not booting linux).
> > 
> > I need to work around what I can't fix otherwise.  So far, the proc entry is
> > the only solution I have seen.
> 
> If those utils just open and read some files under /proc, you could 
> always overmount those files or use some LD_PRELOAD magic.

No no, I'm using /proc to set the right geometry.  The programs use
HDGETGEO.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
