Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261318AbVEXBMK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261318AbVEXBMK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 21:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261332AbVEXBHf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 21:07:35 -0400
Received: from pat.uio.no ([129.240.130.16]:52136 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261318AbVEXBEa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 21:04:30 -0400
Subject: Re: NFS corruption on 2.6.11.7
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Kenneth Johansson <ken@kenjo.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1116894917.11483.111.camel@lade.trondhjem.org>
References: <1116888428.5206.14.camel@tiger>
	 <1116894917.11483.111.camel@lade.trondhjem.org>
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 May 2005 21:04:24 -0400
Message-Id: <1116896664.11483.114.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 8BIT
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.866, required 12,
	autolearn=disabled, AWL 1.13, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

må den 23.05.2005 Klokka 20:35 (-0400) skreiv Trond Myklebust:
> ty den 24.05.2005 Klokka 00:47 (+0200) skreiv Kenneth Johansson:

> > This is what cat /proc/mounts reports on the nfs mount
> > 
> > :/export/home/ken /home/ken nfs rw,v3,rsize=32768,wsize=32768,hard,udp,lock,addr=amd 0 0
> > 

BTW: Why is /proc/mounts reporting the server as being an empty string?
Normally, the "mount" program should be setting that to whatever you
specified on the command line.

Cheers,
  Trond

