Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264925AbUBIHGr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 02:06:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264927AbUBIHGr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 02:06:47 -0500
Received: from maverick.eskuel.net ([81.56.212.215]:61677 "EHLO
	maverick.eskuel.net") by vger.kernel.org with ESMTP id S264925AbUBIHGq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 02:06:46 -0500
Message-ID: <40273184.4060209@eskuel.net>
Date: Mon, 09 Feb 2004 08:06:44 +0100
From: Mathieu LESNIAK <maverick@eskuel.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20040205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel Oops
References: <40261814.1020407@eskuel.net> <20040208163549.GB2531@kroah.com>
In-Reply-To: <20040208163549.GB2531@kroah.com>
X-Enigmail-Version: 0.83.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Sun, Feb 08, 2004 at 12:05:56PM +0100, Mathieu LESNIAK wrote:
> 
>>Hi !
>>
>>I've got this kernel oops with 2.6.3-rc1 when I remove an usb 
>>peripheral. The result is the same if USB UHCI is compiled statically or 
>>in module.
>>Please find in attachment the output of lspci and .config
> 
> 
> The usbscanner driver is obsoleted, marked as broken, and removed
> completely in the -mm tree and my usb tree.  Those changes will get sent
> to Linus in a day or so.
> 
> In short, don't use this module, it's known to be broken and not needed.

Ok, thanks for the advice.

Mathieu LESNIAK
