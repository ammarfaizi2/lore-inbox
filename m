Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966359AbWLDUGL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966359AbWLDUGL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 15:06:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966387AbWLDUGL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 15:06:11 -0500
Received: from mail.kolumbus.fi ([193.229.0.46]:47193 "EHLO mail.kolumbus.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966359AbWLDUGI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 15:06:08 -0500
From: Janne Karhunen <Janne.Karhunen@gmail.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: Mounting NFS root FS
Date: Mon, 4 Dec 2006 22:05:57 +0200
User-Agent: KMail/1.9.5
Cc: MrUmunhum@popdial.com, linux-kernel@vger.kernel.org
References: <4571CE06.4040800@popdial.com> <200612041912.30527.Janne.Karhunen@gmail.com> <1165256490.711.233.camel@lade.trondhjem.org>
In-Reply-To: <1165256490.711.233.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612042205.57577.Janne.Karhunen@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 04 December 2006 20:21, Trond Myklebust wrote:

> > > 2) NFS provides persistent storage.
> >
> > To me this sounds like a chicken and an egg problem. It
> > both depends and provides this at the same time :/. But
> > hey, if it's supposed to work then OK.
>
> ??? Locking depends on persistent storage, but persistent storage never
> depended on locking.

Except for the fact that to be able to mount anything RW you
generally _want_ to have locks. And can't have locks without 
the mount. Not that it wouldn't work, it's just that I would
not do it [for obvious reasons].


> 2) No. The problem of client crashes was fixed in NFSv4 with the
> addition of lease-based locks.

This was NFSv3 system, so that would still be an issue.


-- 
// Janne
