Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262936AbTCSGxp>; Wed, 19 Mar 2003 01:53:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262937AbTCSGxp>; Wed, 19 Mar 2003 01:53:45 -0500
Received: from pimout4-ext.prodigy.net ([207.115.63.103]:62629 "EHLO
	pimout4-ext.prodigy.net") by vger.kernel.org with ESMTP
	id <S262936AbTCSGxp>; Wed, 19 Mar 2003 01:53:45 -0500
Message-Id: <200303190704.h2J74gWE193004@pimout4-ext.prodigy.net>
Content-Type: text/plain; charset=US-ASCII
From: dan carpenter <d_carpenter@sbcglobal.net>
To: Eric Benson <eric_a_benson@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: ide-scsi failure on 2.5.65
Date: Tue, 18 Mar 2003 14:44:07 +0100
X-Mailer: KMail [version 1.3.2]
References: <20030318231033.31663.qmail@web10105.mail.yahoo.com>
In-Reply-To: <20030318231033.31663.qmail@web10105.mail.yahoo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 19 March 2003 12:10 am, Eric Benson wrote:
> I installed Red Hat 8.0 on an IBM NetVista 2283-55U,
> an all-in-one desktop 1.8ghz P4. I downloaded and
> compiled the 2.5.65 kernel with ide-scsi emulation and
> kernel debugging enabled.
>
...
> 14:18:33 hdb: drive not ready for command
> 14:18:33 ide-scsi: reset called for 0
> 14:18:33 bad: scheduling while atomic!

This problem is known.  Try the driver from the -ac kernel.

thanks,
dan carpenter
