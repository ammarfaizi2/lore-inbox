Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267427AbUH1QXE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267427AbUH1QXE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 12:23:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267451AbUH1QUw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 12:20:52 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:30728 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S267423AbUH1QS5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 12:18:57 -0400
Date: Sat, 28 Aug 2004 18:18:48 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Al <wizard@slacky.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Logitech optical usb mouse and vfat partition passing from 2.6.7 to 2.6.8.1 kernel
Message-ID: <20040828161848.GA6802@pclin040.win.tue.nl>
References: <200408281704.27031.wizard@slacky.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408281704.27031.wizard@slacky.it>
User-Agent: Mutt/1.4.1i
X-Spam-DCC: dmv.com: mailhost.tue.nl 1181; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 28, 2004 at 05:04:26PM +0200, Al wrote:

> Second: i cannot mount my vfat partition.
> 
> This is my dmesg log:
> 
> [...]
> Unable to load NLS charset cp437
> FAT: codepage cp437 not found
> [...]

Does it help if you put CONFIG_NLS_CODEPAGE_437=y in your config?
