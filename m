Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266213AbUFRQtt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266213AbUFRQtt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 12:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265356AbUFRQrl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 12:47:41 -0400
Received: from mail.gmx.net ([213.165.64.20]:51928 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265484AbUFRQpO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 12:45:14 -0400
X-Authenticated: #8834078
From: Dominik Karall <dominik.karall@gmx.net>
To: Thomas Latzelsberger <tlatzelsberger@gmx.at>
Subject: Re: limited bandwidth with SiS900 onboard NIC
Date: Fri, 18 Jun 2004 18:57:58 +0200
User-Agent: KMail/1.6.2
Cc: webvenza@libero.it, linux-kernel@vger.kernel.org
References: <40D30FE4.1070900@gmx.at>
In-Reply-To: <40D30FE4.1070900@gmx.at>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406181857.58759.dominik.karall@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 18 June 2004 17:53, Thomas Latzelsberger wrote:
> Dear readers,
>
> As mentioned on http://teg.homeunix.org/sis900.html and
> http://www.latzinator.com/acer_aspire_1705SMi.html there is a problem
> with bandwidth for the SiS900 onboard NIC. I allways use vanilla kernels
> and I'm having had this problem from 2.4.22 to 2.4.24 and from 2.6.2 to
> 2.6.6.
> The symptom is easy to explain. I connect the PC to a 100MBit switch and
> no matter which method of transfer (ftp, scp, samba, nfs) I use, I get a
> maximum transfer rate of less than 400kB/s. By accident I found a dirty
> workaround that might be a hint for some tech savvy hackers: if I force
> the NIC to use halfduplex (allthough it's connected to a switch) it
> works like expected (7-8 MB/s).
>
> The only help I can be is that I can test new kernel drivers and send
> you feedback.
>
> Any help highly appreciated,
>
> Thomas Latzelsberger

Hi,
try the sis900-fix-phy-transceiver-detection.patch which you can find in -mm 
patches. It works fine for me, as I had the same problem.
A few days ago, I asked why that patch wasn't moved to stable tree. Here you 
can find the mail:
http://lkml.org/lkml/2004/6/16/182

greets dominik
