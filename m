Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261775AbTJHWHi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 18:07:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261784AbTJHWHi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 18:07:38 -0400
Received: from smtp02.web.de ([217.72.192.151]:1560 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S261775AbTJHWHh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 18:07:37 -0400
From: Bernd Schubert <bernd-schubert@web.de>
To: Torsten Werner <email@twerner42.de>
Subject: Re: NFS speed problem when appending data to existing files
Date: Thu, 9 Oct 2003 00:08:14 +0200
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310090008.14366.bernd-schubert@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> on the client side (2.4.22, server is a 2.4.21 kernel based nfsd). Only
> appending small amounts of data to an existing file shows the problem.
> Writing a large file happens at FastEthernet speed flawlessly. Any help,
> please?
> 

Hello Torsten,

2.4.22 has a client-side nfs-bug causing this. I'm not sure if this is already 
fixed in 2.4.23-pre6, so I suggest you downgrade to 2.4.21.

Cheers,
	Bernd

