Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265715AbUF2LMc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265715AbUF2LMc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 07:12:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265716AbUF2LMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 07:12:32 -0400
Received: from 8.75.30.213.rev.vodafone.pt ([213.30.75.8]:64273 "EHLO
	odie.graycell.biz") by vger.kernel.org with ESMTP id S265715AbUF2LM0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 07:12:26 -0400
Subject: Re: Process hangs copying large file to cifs
From: Nuno Ferreira <nuno.ferreira@graycell.biz>
To: Steve French <smfltc@us.ibm.com>
Cc: linux-cifs-client@lists.samba.org, linux-kernel@vger.kernel.org
In-Reply-To: <1088459930.5666.8.camel@stevef95.austin.ibm.com>
References: <1088459930.5666.8.camel@stevef95.austin.ibm.com>
Content-Type: text/plain
Organization: Graycell
Date: Tue, 29 Jun 2004 12:12:24 +0100
Message-Id: <1088507544.2418.1.camel@taz.graycell.biz>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9.1 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Jun 2004 11:12:24.0804 (UTC) FILETIME=[F4AD8A40:01C45DC9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Seg, 2004-06-28 at 16:58 -0500, Steve French wrote:
> >  > This is copying a 197Mb from an my laptop's IDE hardisk to a cifs 
> > mounted share that's on a Win2000 Server
> 
> Linus had suggested hashing cifs inodes, which makes sense as related to
> the problem that you reported.  I have coded that and it tested out ok
> today. If you have a chance could you try the patch at:
> 
> http://cifs.bkbits.net:8080/linux-2.5cifs/gnupatch@40e0925dAlasT6JDoPqQE2q3e-zYiw

I applied it by hand to plain 2.6.7 (had some rejects) and it appears to
work. Thank you.
I just copied a 600Mb from my laptop to the server with no problems,
continued to work on my desktop with no visible effects.
Great work.
-- 
Nuno Ferreira

