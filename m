Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265913AbUAMXir (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 18:38:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265925AbUAMXir
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 18:38:47 -0500
Received: from forty.greenhydrant.com ([208.48.139.185]:16823 "EHLO
	forty.greenhydrant.com") by vger.kernel.org with ESMTP
	id S265913AbUAMXiq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 18:38:46 -0500
Message-ID: <3156.208.48.139.163.1074037125.squirrel@www.greenhydrant.com>
In-Reply-To: <20040113150319.1e309dcb.rddunlap@osdl.org>
References: <20040113215355.GA3882@piper.madduck.net><20040113143053.1c44b97d.rddunlap@osdl.org><20040113223739.GA6268@piper.madduck.net><20040113144141.1d695c3d.rddunlap@osdl.org><20040113225047.GA6891@piper.madduck.net>
    <20040113150319.1e309dcb.rddunlap@osdl.org>
Date: Tue, 13 Jan 2004 15:38:45 -0800 (PST)
Subject: Re: modprobe failed: digest_null
From: "David Rees" <drees@greenhydrant.com>
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, January 13, 2004 at 3:03 pm, Randy.Dunlap wrote:
>
> OK, maybe someone else has an answer then.
>
> The message:
> kernel: request_module: failed /sbin/modprobe -- digest_null. error = 256
> is from modutils and not from module-init-tools according to my
> source files.

I'm getting similar messages from dmesg after upgrading to 2.6.1, too:

request_module: failed /sbin/modprobe -- n. error = 256

[drees@summit drees]$ /sbin/modprobe -V
module-init-tools version 3.0-pre5
[drees@summit drees]$

Running on Fedora Core 1 compiled with gcc 3.3.2.  Didn't see these with
2.6.0.

-Dave
