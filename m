Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262923AbRFRNWh>; Mon, 18 Jun 2001 09:22:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262982AbRFRNW1>; Mon, 18 Jun 2001 09:22:27 -0400
Received: from c012-h010.c012.sfo.cp.net ([209.228.13.104]:5076 "HELO
	c012.sfo.cp.net") by vger.kernel.org with SMTP id <S262923AbRFRNWR>;
	Mon, 18 Jun 2001 09:22:17 -0400
Date: 18 Jun 2001 06:21:56 -0700
Message-ID: <20010618132156.24334.cpmta@c012.sfo.cp.net>
X-Sent: 18 Jun 2001 13:21:56 GMT
Content-Type: text/plain
Content-Disposition: inline
Mime-Version: 1.0
To: linux-kernel@vger.kernel.org
From: Ralph Jones <ralph.jones@altavista.com>
X-Mailer: Web Mail 3.9.3.1
Subject: Re: Can't free the ramdisk (initrd, pivot_root)
X-Sent-From: ralph.jones@altavista.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun Apr 15 2001 - 15:57:52, EST Amit D Chaudhary (amit@muppetlabs.com) wrote:

>  On the same topic, I have not found any change in free memory reported before 
>  and after the ioctl call. Though umount /initrd does free around 2 MB. 

I have found the same thing - that umount /initrd seems to free the memory and that freeramdisk (with the patch to rd.c) does not appear to do anything.  

I have not found any more correspondance about this topic and was wondering if this behaviour was ok.  Specifically I would like to know if I need to apply the rd.c patch and then to run freeramdisk, or if I can just leave this out.  

Ralph Jones

Find the best deals on the web at AltaVista Shopping!
http://www.shopping.altavista.com
