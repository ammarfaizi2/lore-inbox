Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932321AbVLUIF3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932321AbVLUIF3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 03:05:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932315AbVLUIF3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 03:05:29 -0500
Received: from smtpq1.groni1.gr.home.nl ([213.51.130.200]:13464 "EHLO
	smtpq1.groni1.gr.home.nl") by vger.kernel.org with ESMTP
	id S932321AbVLUIF3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 03:05:29 -0500
Message-ID: <43A90DD8.1030802@keyaccess.nl>
Date: Wed, 21 Dec 2005 09:10:00 +0100
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
Newsgroups: gmane.linux.kernel
To: David Brownell <david-b@pacbell.net>
CC: Helmut Toplitzer <pvrusb2@toplitzer.net>, linux-kernel@vger.kernel.org
Subject: Re: External USB2 HDD affects speed hda
References: <200512210808.20073.pvrusb2@toplitzer.net>
In-Reply-To: <200512210808.20073.pvrusb2@toplitzer.net>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helmut Toplitzer wrote:

> I stumbled into a quite simmilar problem as Rene Herman. 
> So he asked me to mail to you. Here a short intro:
> 
> My VIA USB driver using EHCI is disconnecting my video
> encoder device (Hauppauge PVRUSB2) after working for
> about 10 minutes.
> 
> Details (including usb-debug output, lspci, lsusb, lsmdo) can be found at:
> http://marc.theaimsgroup.com/?l=linux-usb-users&m=113508572205777&w=2
> 
> Any suggestions what to test/to do?

Just to make it clear -- the striking similarity is that he also has the 
IDE throughput drop; 34MB/s to 15MB/s in his case. No idea if his async 
schedule should be turning on and off with the USB PVR, but it seems 
very likely the same problem...

(hope I don't break the thread; replying through the gmane news gateway)

Rene.

