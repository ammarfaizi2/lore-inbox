Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265373AbUFBGzb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265373AbUFBGzb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 02:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265376AbUFBGzb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 02:55:31 -0400
Received: from [209.101.250.228] ([209.101.250.228]:64130 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S265373AbUFBGza convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 02:55:30 -0400
Subject: Re: NFS client behavior on close
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Simon Kirby <sim@netnation.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040531213820.GA32572@netnation.com>
References: <20040531213820.GA32572@netnation.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1086159327.10317.2.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 01 Jun 2004 23:55:27 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På må , 31/05/2004 klokka 14:38, skreiv Simon Kirby:

> Is the NFS client required to write all data on close?

Yes. That is the basis of the NFSv2/v3 caching model...

Cheers,
  Trond
