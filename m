Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261629AbUCFWnt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Mar 2004 17:43:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261722AbUCFWns
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Mar 2004 17:43:48 -0500
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:55046 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261629AbUCFWnr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Mar 2004 17:43:47 -0500
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: garski@poczta.onet.pl, linux-kernel@vger.kernel.org
Subject: Re: Data corruption during read on VIA vt8235
Date: Sun, 7 Mar 2004 00:38:08 +0200
User-Agent: KMail/1.5.4
References: <4048EB33.7030900@poczta.onet.pl>
In-Reply-To: <4048EB33.7030900@poczta.onet.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403070038.08472.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 05 March 2004 23:03, Marcin Garski wrote:
> [Please CC me on replies, I am not subscribed to the list, thanks]
> Hi,
>
> I've Soltek SL-75FRV mainboard (VIA KT400 and vt8235 chipsets).
> Also i've two IDE disk both runing on UDMA(100) (DMA enabled).
> I'm using 2.4.22 kernel from Fedora Core 1 + patch for XFS suppport.
>
> Several checking md5 sum of big file (650MB) give different results
> (e.g: first, second and third* *file check give good md5 sum, but fourth
> check give bad sum).
> Also if i copy big file through network (ethernet), file have bits
> difference, the same
> thing happen during file copy (also big file) betwen two disks.
> Usually there are from 1 to 3 differneces in file, each difference is
> one bit  (e.g good file - 4B, bad file - 4A).

If md5sum fails, those too will fail.

> That is not a memory problem because memtest86 shows no errors.
>
> I found some old message:
> http://www.ussg.iu.edu/hypermail/linux/kernel/0111.0/0914.html
> where author had similar problem to mine.
>
> Could you give me some hints how to more deeply diagnose this problem.

Does it happen with UDMA66? UDMA33? etc
Kernel .config?
--
vda

