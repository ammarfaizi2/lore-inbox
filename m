Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261365AbVAaU4T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261365AbVAaU4T (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 15:56:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261361AbVAaUyc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 15:54:32 -0500
Received: from rproxy.gmail.com ([64.233.170.198]:2344 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261360AbVAaUxO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 15:53:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=fzZFjaaFqG5O3yOG0ypayUWi+QDMTRjG5Dsv9ECu6xmFNPEfGFHJa9EctHU5hNEw+BIakrnkPVjq/TRR2VDr0RIosLswxydQn/DbeLNyf6L/48IoeCKwTv719QEQhgKLb+WHn6axgzLBkxPKPjNHRCUNzhv345kBZdd2KYT+On0=
Message-ID: <8a966de8050131125334277f88@mail.gmail.com>
Date: Mon, 31 Jan 2005 18:53:10 -0200
From: Leslie Watter <leslie.watter@gmail.com>
Reply-To: Leslie Watter <leslie.watter@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: NPROTO vs AF_MAX defines
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Looking into /usr/src/include/linux/net.h:29 
we have the following define: 
-----------------
#define NPROTO 32
-----------------

Is this '32' the same number used to define AF_MAX 
(/usr/src/include/linux/socket.h)?

-------
06:50  leslie@cronos linux> grep AF_MAX socket.h 
#define AF_MAX          32      /* For now.. */
#define PF_MAX          AF_MAX
------

Sorry if this sounds too basically.

Cheers,

LEslie
