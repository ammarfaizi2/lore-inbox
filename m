Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261814AbVB1XXq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261814AbVB1XXq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 18:23:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261815AbVB1XXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 18:23:46 -0500
Received: from main.gmane.org ([80.91.229.2]:34719 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261814AbVB1XXo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 18:23:44 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Richard Hughes <ee21rh@surrey.ac.uk>
Subject: Re: status of the USB ov511.c driver in kernel 2.6?
Date: Mon, 28 Feb 2005 23:21:06 +0000
Message-ID: <pan.2005.02.28.23.21.06.203575@surrey.ac.uk>
References: <20050228224813.GT4021@stusta.de>
Reply-To: ee21rh@surrey.ac.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host81-153-6-170.range81-153.btcentralplus.com
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity.)
X-Gmane-MailScanner: Found to be clean
X-Gmane-MailScanner: Found to be clean
X-Gmane-MailScanner-SpamScore: ss
X-MailScanner-From: glk-linux-kernel@m.gmane.org
X-MailScanner-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Feb 2005 23:48:13 +0100, Adrian Bunk wrote:
> - there's no *_decomp.c module in the kernel sources

If I remember correctly people are bit uneasy about putting
decompression of proprietary codecs into to the kernel.

See
http://www.mail-archive.com/linux-usb-devel@lists.sourceforge.net/msg04778.html

Every kernel release I end up building an external module just to get my
OV518 usb webcam to work. (It requires decompression support) Not cool.

> Are there any reasons why the upstream driver can't be resynced with the 
> kernel?

I think ovcamchip is from the development branch, but ov511 is from the
stable branch. Not sure about that. Best bet is contact Mark McClelland
(maintainer) here:

mmcclell <atsign> calpoly.edu 
or mark <atsign> alpha.dyndns.org

Richard Hughes

-- 

http://www.hughsie.com/PUBLIC-KEY


