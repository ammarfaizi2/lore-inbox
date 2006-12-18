Return-Path: <linux-kernel-owner+w=401wt.eu-S1752113AbWLRDBO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752113AbWLRDBO (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 22:01:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752141AbWLRDBO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 22:01:14 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:4177 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752113AbWLRDBN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 22:01:13 -0500
Date: Mon, 18 Dec 2006 04:01:13 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Komuro <komurojun-mbn@nifty.com>, jgarzik@pobox.com
Cc: Al Viro <viro@ftp.linux.org.uk>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [BUG KERNEL 2.6.20-rc1]  ftp: get or put stops during file-transfer
Message-ID: <20061218030113.GT10316@stusta.de>
References: <20061217212752.d93816b4.komurojun-mbn@nifty.com> <20061217040222.GD17561@ftp.linux.org.uk> <20061217232311.f181302f.komurojun-mbn@nifty.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061217232311.f181302f.komurojun-mbn@nifty.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 17, 2006 at 11:23:11PM +0900, Komuro wrote:
> On Sun, 17 Dec 2006 04:02:22 +0000
> Al Viro <viro@ftp.linux.org.uk> wrote:
> 
> > On Sun, Dec 17, 2006 at 09:27:52PM +0900, Komuro wrote:
> > > 
> > > Hello,
> > > 
> > > On kernel 2.6.20-rc1, ftp (get or put) stops
> > > during file-transfer.
> > > 
> > > Client: ftp-0.17-33.fc6  (192.168.1.1)
> > > Server: vsftpd-2.0.5-8   (192.168.1.3)
> > > 
> > > This problem does _not_ happen on kernel-2.6.19.
> > > is it caused by network-subsystem change on 2.6.20-rc1??
> > 
> > Do you have NAT between you and server?
> 
> No. I don't have NAT between the client and the server.
> Actually, the client and the sever is located in same room.
> 
> client -- 100MbpsHub -- server.

What network cards are in the client and the server?

Are there any error messages your client gives or in the log files?

> Thanks!
> 
> Best Regards
> Komuro

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

