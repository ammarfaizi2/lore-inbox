Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262459AbVAKUGJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262459AbVAKUGJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 15:06:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262496AbVAKUGJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 15:06:09 -0500
Received: from zeus.city.tvnet.hu ([195.38.100.182]:3501 "EHLO
	zeus.city.tvnet.hu") by vger.kernel.org with ESMTP id S262459AbVAKUGA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 15:06:00 -0500
Subject: Re: Unable to burn DVDs
From: Sipos Ferenc <sferi@mail.tvnet.hu>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0501112008080.7967@yvahk01.tjqt.qr>
References: <41E2F823.1070608@apartia.fr>
	 <Pine.LNX.4.61.0501110802180.8535@yvahk01.tjqt.qr>
	 <41E41B32.9070206@apartia.fr>
	 <Pine.LNX.4.60.0501111943500.8024@alpha.polcom.net>
	 <Pine.LNX.4.61.0501112008080.7967@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Date: Tue, 11 Jan 2005 21:09:03 +0100
Message-Id: <1105474144.15542.1.camel@zeus.city.tvnet.hu>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

For me, dvd writing works only when I run growisofs with root
permissions (using 2.6.10 kernel, /dev/hdc without ide-scsi)

Feri

2005-01-11, k keltezéssel 20.10-kor Jan Engelhardt ezt írta:
> > Also there is packet cdrw/dvd+-rw driver in kernel now (2.6.10?) that permits
> 
> I've got susekotd-2.6.8-0, which is a 2.6.9-rc2 if I'm not mistaken. 
> 
> > you to mount normal filesystem (for example UDF, but FAT or ISO - readonly of
> 
> No, it's all read-write, see 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=110297545900945&w=2
> (It's really readwrite, no "-o ro" done by user- or kernelspace)
> 
> > course or EXT2 or any other but better for your media without journal) on such
> > device.
> 
> 
> 
> Jan Engelhardt
