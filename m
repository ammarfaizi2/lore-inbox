Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265250AbUF1WDW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265250AbUF1WDW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 18:03:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265248AbUF1WDW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 18:03:22 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:41390 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265255AbUF1WBk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 18:01:40 -0400
Subject: Re: Process hangs copying large file to cifs
From: Steve French <smfltc@us.ibm.com>
To: nuno.ferreira@graycell.biz
Cc: linux-cifs-client@lists.samba.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: IBM
Message-Id: <1088459930.5666.8.camel@stevef95.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 28 Jun 2004 16:58:50 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  > This is copying a 197Mb from an my laptop's IDE hardisk to a cifs 
> mounted share that's on a Win2000 Server

Linus had suggested hashing cifs inodes, which makes sense as related to
the problem that you reported.  I have coded that and it tested out ok
today. If you have a chance could you try the patch at:

http://cifs.bkbits.net:8080/linux-2.5cifs/gnupatch@40e0925dAlasT6JDoPqQE2q3e-zYiw


