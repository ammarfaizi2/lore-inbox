Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265206AbTFRMls (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 08:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265209AbTFRMls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 08:41:48 -0400
Received: from smtp-send.myrealbox.com ([192.108.102.143]:55819 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S265206AbTFRMlr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 08:41:47 -0400
Message-ID: <3EF06154.6030401@myrealbox.com>
Date: Wed, 18 Jun 2003 05:55:48 -0700
From: walt <wa1ter@myrealbox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; FreeBSD i386; en-US; rv:1.4b) Gecko/20030517
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Sourabh Ladha (EED)" <Sourabh.Ladha@eed.ericsson.se>
CC: linux-kernel@vger.kernel.org
Subject: Re: Kernel Panic while upgrading from 2.4.20 to 2.5.70
References: <fa.o798dld.25grp5@ifi.uio.no>
In-Reply-To: <fa.o798dld.25grp5@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sourabh Ladha (EED) wrote:
> Hi,
> 
> [I know this has been discussed before but I tried the previous fixes proposed without luck..so]
> 
> I was trying to upgrade my kernel from 2.4.20 to 2.5.70. (I am running RedHat 9). After getting the sources I did:
> 
> make clean; make mrproper; make distclean; make menuconfig; make bzImage; make modules; make modules_install; make install   (got past all of these)
> 
> The make install updated my grub.conf as well...

Just a wild guess:  did you upgrade modutils to module-init-tools?  2.5.x won't be happy
until you do.


