Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263351AbUCNMZE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 07:25:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263350AbUCNMZE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 07:25:04 -0500
Received: from main.gmane.org ([80.91.224.249]:62650 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263351AbUCNMZA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 07:25:00 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?ISO-8859-1?Q?Sven_K=F6hler?= <skoehler@upb.de>
Subject: Re: [2.6.4] IDE performance drop again
Date: Sun, 14 Mar 2004 13:23:28 +0100
Message-ID: <c31iup$r2f$1@sea.gmane.org>
References: <20040314115727.GA21362@sun1000.pwr.wroc.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd9e58ef3.dip.t-dialin.net
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: de, en
In-Reply-To: <20040314115727.GA21362@sun1000.pwr.wroc.pl>
X-Enigmail-Version: 0.83.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> hdparm /dev/hda
> 
> /dev/hda:
>  multcount    =  1 (on)

This should be 16 if you've got a modern harddisk
use -m 16 instead of -m 1

>  IO_support   =  1 (32-bit)
>  unmaskirq    =  1 (on)
>  using_dma    =  1 (on)
>  keepsettings =  0 (off)
>  readonly     =  0 (off)
>  readahead    = 8192 (on)
>  geometry     = 26310/16/63, sectors = 26520480, start = 0

other things look fine

