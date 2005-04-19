Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261629AbVDSTX3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261629AbVDSTX3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 15:23:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261631AbVDSTX3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 15:23:29 -0400
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:56235 "EHLO
	mail-in-07.arcor-online.net") by vger.kernel.org with ESMTP
	id S261252AbVDSTXT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 15:23:19 -0400
Date: Tue, 19 Apr 2005 18:02:43 +0200 (CEST)
From: Bodo Eggert <7eggert@gmx.de>
To: Eric Van Hensbergen <ericvh@gmail.com>
Cc: Bodo Eggert <7eggert@gmx.de>, Miklos Szeredi <miklos@szeredi.hu>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       hch@infradead.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [RFC] FUSE permission modell (Was: fuse review bits)
In-Reply-To: <a4e6962a05041908262df343f1@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0504191756200.3929@be1.lrz>
References: <3Ki1W-2pt-1@gated-at.bofh.it> <3S8oN-So-21@gated-at.bofh.it> 
 <3S8oN-So-23@gated-at.bofh.it> <3S8oN-So-25@gated-at.bofh.it> 
 <3S8oN-So-27@gated-at.bofh.it> <3S8oM-So-7@gated-at.bofh.it> 
 <3UmnD-6Fy-7@gated-at.bofh.it>  <E1DNJZD-0006vK-11@be1.7eggert.dyndns.org>
  <a4e6962a050419045752cc8be0@mail.gmail.com>  <Pine.LNX.4.58.0504191647320.3652@be1.lrz>
 <a4e6962a05041908262df343f1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Apr 2005, Eric Van Hensbergen wrote:
> On 4/19/05, Bodo Eggert <7eggert@gmx.de> wrote:

> > Allowing user mounts with no* should be allways ok (no config needed
> > besides the ulimit), and mounting specified files to defined locations
> > is allready supported by fstab.
> >
> 
> Do folks think that the limits should be per-user or per-process for
> user-mounts, what about separate limits for # of private namespaces
> and # of mounts?

Per-user.

> The fstab support doesn't seem to provide enough flexibility for
> certain situations, say I want to support mounting any remote file
> system, as long as its in the user's private hierarchy?
[...]

The dir is owned by the user, therefore it's allowed with no*.
-- 
Top 100 things you don't want the sysadmin to say:
11. Can you get VMS for this Sparc thingy?
