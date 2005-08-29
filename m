Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751420AbVH2ThS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751420AbVH2ThS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 15:37:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751424AbVH2ThS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 15:37:18 -0400
Received: from cramus.icglink.com ([66.179.92.18]:60808 "EHLO mx03.icglink.com")
	by vger.kernel.org with ESMTP id S1751420AbVH2ThO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 15:37:14 -0400
Date: Mon, 29 Aug 2005 14:37:09 -0500
From: Phil Dier <phil@icglink.com>
To: linux-kernel@vger.kernel.org
Cc: scott@icglink.com, ziggy@icglink.com, jack@icglink.com
Subject: Re: Slow I/O with megaraid and u160 scsi jbod
Message-Id: <20050829143709.51104ad8.phil@icglink.com>
In-Reply-To: <0E3FA95632D6D047BA649F95DAB60E5703662AF7@exa-atlanta>
References: <0E3FA95632D6D047BA649F95DAB60E5703662AF7@exa-atlanta>
Organization: ICGLink
X-Mailer: Sylpheed version 2.0.0 (GTK+ 2.4.4; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Aug 2005 15:03:43 -0400
"Ju, Seokmann" <sju@lsil.com> wrote:

> Hi,
> 
> > formatted the disks in question with a single JFS partition and they
> > still exhibit this behaviour when used by themselves. I have verified
> > that this behaviour is not present up until at least 2.6.12.3. Let me
> > know what info I can collect that would be helpful.. Thanks.
> Can you please specify following?
> - driver version on 2.6.12.3

>From Documentation/scsi/ChangeLog.megaraid:
Release Date    : Thu Feb 03 12:27:22 EST 2005 - Seokmann Ju <sju@lsil.com>
Current Version : 2.20.4.5 (scsi module), 2.20.2.5 (cmm module)
Older Version   : 2.20.4.4 (scsi module), 2.20.2.4 (cmm module)


> - F/W version on the controller you are using.
> 

scsi2 : ioc0: LSI53C1030, FwRev=01013d00h, Ports=1, MaxQ=255, IRQ=24
                          ^^^^^^^^^^^^^^^

Is this it?  If not, how do you find it?




-- 

Phil Dier (ICGLink.com -- 615 370-1530 x733)

/* vim:set noai nocindent ts=8 sw=8: */
