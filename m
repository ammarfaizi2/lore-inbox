Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265206AbTIIXRK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 19:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265215AbTIIXRK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 19:17:10 -0400
Received: from shopwall.abacus.ch ([193.246.120.14]:14554 "EHLO
	shopwall.abacus.ch") by vger.kernel.org with ESMTP id S265206AbTIIXRG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 19:17:06 -0400
Message-ID: <3F5E5F61.6030406@your.toilet.ch>
Date: Wed, 10 Sep 2003 01:16:49 +0200
From: Remo Inverardi <invi@your.toilet.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030908 Debian/1.4-4
X-Accept-Language: en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: OHCI Host Controler Died
References: <3F5E4D93.9030804@your.toilet.ch> <20030909225125.GA7995@kroah.com>
In-Reply-To: <20030909225125.GA7995@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Report: ---- Start SpamAssassin results
  -0.40 points, 5.5 required;
  * -0.0 -- Has a valid-looking References header
  * -0.4 -- Has a In-Reply-To header
  *  0.0 -- User-Agent header indicates a non-spam MUA (Mozilla)
  ---- End of SpamAssassin results
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg,

> Great, go bug vmware then :)

I will -- but ...

I was under the impression that all of VMware's USB code is running in 
user space. Running "grep -ir usb ." in VMware's modules/source 
directory did not return any hits, so this assumption is probably correct.

This does look like a kernel bug to me, since it should not be possible 
to crash the OHCI driver from user space.

Regards, Remo

