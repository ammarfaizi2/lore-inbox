Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261500AbUF0S7h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbUF0S7h (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 14:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261654AbUF0S7h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 14:59:37 -0400
Received: from ppp2-isdn-24.the.forthnet.gr ([213.16.247.24]:27265 "EHLO
	ppp1-100.the.forthnet.gr") by vger.kernel.org with ESMTP
	id S261500AbUF0S7g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 14:59:36 -0400
From: V13 <v13@priest.com>
To: Lionel Bouton <Lionel.Bouton@inet6.fr>
Subject: Re: Elastic Quota File System (EQFS)
Date: Sun, 27 Jun 2004 21:18:23 +0300
User-Agent: KMail/1.6.52
Cc: linux-kernel@vger.kernel.org
References: <20040624213041.GA20649@elf.ucw.cz> <20040624220318.GE20649@elf.ucw.cz> <40DBD9AD.8070503@inet6.fr>
In-Reply-To: <40DBD9AD.8070503@inet6.fr>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200406272118.23510.v13@priest.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 25 June 2004 10:52, Lionel Bouton wrote:
> Pavel Machek wrote the following on 06/25/2004 12:03 AM :
> >Of course, if mozilla marked them "elastic" it should better be
> >prepared for they disappearance. I'd disappear them with simple
> >unlink(), so they'd physically survive as long as someone held them
> >open.
>
> Doesn't work reliably : the deletion is done in order to reclaim space
> that is needed now. You may want to retry unlinking files until you
> reach the free space needed, but this is clearly a receipe for famine :
> process can wait on writes an unspecified amount of time.

This could be solved like OOM by killing all related processes.

<<V13>>
