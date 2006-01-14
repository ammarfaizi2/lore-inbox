Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751115AbWANJVq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751115AbWANJVq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 04:21:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751119AbWANJVq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 04:21:46 -0500
Received: from wproxy.gmail.com ([64.233.184.198]:4744 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751115AbWANJVq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 04:21:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:to:subject:message-id:mime-version:content-type:content-disposition:user-agent:from;
        b=Q/Yqvw5UyYbTaFUSYM9lCDc4hT5WOrKqySCE4hOTae5B4xUX15BRuNaGzN99rdx8DK6M6vpUqrf0WWdcP4LO+f088oaPIK3p9kPRlbP6/M7+32lAzjvVSMXNnfKwxzhHXA10+yrHy5Q/v6+TNPmc07KiqOgJZ3ygcrLyMo/ehIM=
Date: Sat, 14 Jan 2006 04:21:42 -0500
To: linux-kernel@vger.kernel.org
Subject: 'serial' cannot be built as module
Message-ID: <20060114092142.GA10844@roll>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
From: tmhikaru@gmail.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've already tried reporting this to the maintainer in the MAINTAINERS file,
but received no response (mail originally sent 15'th of november)

Essentially, the 'serial' module is not, apparently, being built when set as
modular. I definitely know it's not being installed when I do make
modules_install.

However, if I include it in the kernel, it works. The 'symbol' is SERIAL_8250
according to the help in menuconfig.

I'd really like to have this fixed, as I try to reduce the size of the
kernel that I boot, as I have to load the kernel off a floppy disk.

Timothy C. McGrath
