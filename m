Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261408AbVBGMcx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261408AbVBGMcx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 07:32:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261410AbVBGMcx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 07:32:53 -0500
Received: from lucidpixels.com ([66.45.37.187]:48021 "HELO lucidpixels.com")
	by vger.kernel.org with SMTP id S261408AbVBGMcu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 07:32:50 -0500
Date: Mon, 7 Feb 2005 07:32:48 -0500 (EST)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p500
To: linux-kernel@vger.kernel.org
Subject: Reading Bad DVD Under 2.6.10 freezes the box.
Message-ID: <Pine.LNX.4.62.0502070728520.1743@p500>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a DVD where I have three files on it, (1.7gb,1.7gb,900mb).

On W2K, when I try to copy the second file, I get a BadCRC error message.

Under Linux, I copy up to about 860MB (watched via pipebench) and then it 
freezes the machine, I cannot ping or get to it or do anything on the 
console; instead, I am forced to hard reboot.

Main Question >> Why does Linux 'freeze up' when W2K gives a BadCRC error 
msg (never freezes)?

The DVD FS is Joilet+ISO (hence, why none of the files are bigger than 
2GB), is this normal?  Or is there no checking code when there are errors 
on DVD's to kill the read/etc so it does not freeze the box?

Thanks.
