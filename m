Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263005AbVD2Vlq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263005AbVD2Vlq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 17:41:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262991AbVD2VjF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 17:39:05 -0400
Received: from pat.uio.no ([129.240.130.16]:20670 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S263005AbVD2ViU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 17:38:20 -0400
Subject: Re: which ioctls matter across filesystems
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Steve French <smfrench@austin.rr.com>
Cc: Robert Love <rml@novell.com>, linux-kernel@vger.kernel.org
In-Reply-To: <4272A582.3040709@austin.rr.com>
References: <42728964.8000501@austin.rr.com>
	 <1114804426.12692.49.camel@lade.trondhjem.org>
	 <1114805033.6682.150.camel@betsy>
	 <1114807360.12692.77.camel@lade.trondhjem.org>
	 <1114807648.6682.153.camel@betsy>
	 <1114809199.12692.96.camel@lade.trondhjem.org>
	 <4272A582.3040709@austin.rr.com>
Content-Type: text/plain
Date: Fri, 29 Apr 2005 17:38:05 -0400
Message-Id: <1114810685.12692.109.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.892, required 12,
	autolearn=disabled, AWL 1.11, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fr den 29.04.2005 Klokka 16:22 (-0500) skreiv Steve French:

> Very interesting, I had not seen that.   FYI - There are many years of 
> real world experience on the current transact2 notify (it is deployed in 
> some form on most clients) but I don't know whether one of the NAS 
> storage companies or researchers has done a good research paper on this 
> topic - although there is no lack of customer traces in SPEC and SNIA.

If you are able to release those traces to them, then CITI does have a
simulator that can be used to test the various models. It is currently
only capable of analysing NFSv3 and v4 traffic, but it might perhaps be
possible to add a CIFS interpreter onto it.

Cheers,
  Trond
-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

