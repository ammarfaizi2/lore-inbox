Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262805AbUAUKPd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 05:15:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265890AbUAUKPd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 05:15:33 -0500
Received: from users.linvision.com ([62.58.92.114]:60115 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S262805AbUAUKPc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 05:15:32 -0500
Date: Wed, 21 Jan 2004 11:15:30 +0100
From: Erik Mouw <erik@harddisk-recovery.com>
To: keirwu pk <kwpk_55@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: newbie driver question
Message-ID: <20040121101530.GF24745@bitwizard.nl>
References: <BAY13-F43DRdNOUivlQ00007193@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BAY13-F43DRdNOUivlQ00007193@hotmail.com>
User-Agent: Mutt/1.3.28i
Organization: Harddisk-recovery.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 21, 2004 at 05:33:10AM +0000, keirwu pk wrote:
> what is the best way to write scsi driver for a scsi device?.got latest 
> kernel.
> any examples, sources. what are typical library calls?.  sg-Howto would 
> help?.

The sg interface is all you need to write a driver for some kind of
exotic scsi device. Everything is handled in userland, no need to do it
in kernel. That's how scsi scanners and cd writers are handled.
The scsi-generic howto tells you how to use it, it even has programming
examples.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
