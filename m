Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261996AbUDOKhx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 06:37:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261891AbUDOKhx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 06:37:53 -0400
Received: from smtp.rol.ru ([194.67.21.9]:34558 "EHLO smtp.rol.ru")
	by vger.kernel.org with ESMTP id S261804AbUDOKhs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 06:37:48 -0400
From: Konstantin Sobolev <kos@supportwizard.com>
Reply-To: kos@supportwizard.com
Organization: SupportWizard
To: Lenar =?iso-8859-1?q?L=F5hmus?= <lenar@vision.ee>
Subject: Re: poor sata performance on 2.6
Date: Thu, 15 Apr 2004 14:40:23 +0400
User-Agent: KMail/1.6.1
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
References: <200404150236.05894.kos@supportwizard.com> <407E35E0.3080902@vision.ee>
In-Reply-To: <407E35E0.3080902@vision.ee>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200404151440.23858.kos@supportwizard.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 15 April 2004 11:12, Lenar Lõhmus wrote:
> >for sata_sil:
> >
> >/dev/sda:
> > Timing buffer-cache reads:   1412 MB in  2.00 seconds = 705.05 MB/sec
> > Timing buffered disk reads:   84 MB in  3.06 seconds =  27.43 MB/sec
> >
> >So my old IDE HDD appears to be considerably faster. Expected results were
> >55-70MB/s.
>
> With same hard drive connected to 3ware S-ATA controller I got
> 40-50MB/sec with hdparm on 2.6.4 and 2.6.5. Then
> tried to hdparm -a 8192 /dev/sda, and got this:
>
> /dev/sda:
>  Timing buffer-cache reads:   2056 MB in  2.00 seconds = 1027.13 MB/sec
>  Timing buffered disk reads:  266 MB in  3.00 seconds =  88.53 MB/sec
>
> So you may try that switch, maybe helps.

unfortunately it doesn't:

/dev/sda:
 setting fs readahead to 8192
 readahead    = 8192 (on)
 Timing buffered disk reads:   84 MB in  3.06 seconds =  27.46 MB/sec
-- 
/KoS
* Searching for light in the darkness of insanity.		      
