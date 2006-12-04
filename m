Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937020AbWLDPaE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937020AbWLDPaE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 10:30:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937017AbWLDPaD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 10:30:03 -0500
Received: from pat.uio.no ([129.240.10.15]:53962 "EHLO pat.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937020AbWLDPaA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 10:30:00 -0500
Subject: Re: Mounting NFS root FS
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Janne Karhunen <janne.karhunen@gmail.com>
Cc: MrUmunhum@popdial.com, linux-kernel@vger.kernel.org
In-Reply-To: <24c1515f0612040351p6056101frc12db8eb86063213@mail.gmail.com>
References: <4571CE06.4040800@popdial.com>
	 <24c1515f0612040351p6056101frc12db8eb86063213@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 04 Dec 2006 10:29:37 -0500
Message-Id: <1165246177.711.179.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.381, required 12,
	autolearn=disabled, AWL 1.48, RCVD_IN_SORBS_DUL 0.14,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-12-04 at 13:51 +0200, Janne Karhunen wrote:
> On 12/2/06, William Estrada <MrUmunhum@popdial.com> wrote:
> > Hi guys,
> >
> >   I have been trying to make FC5's kernel do a boot
> > with an NFS root file system.  I see the support is in the
> > kernel(?).
> 
> Is this really properly possible (with read/write access and
> locking in place)? AFAIK NFS client lock state data seems
> to require persistent storage .. ?

1) Yes, but not on the root partition (unless you use an initrd to start
rpc.statd before mounting the NFS partition).

2) NFS provides persistent storage.

Trond

