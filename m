Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285482AbRLSUWb>; Wed, 19 Dec 2001 15:22:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285466AbRLSUUM>; Wed, 19 Dec 2001 15:20:12 -0500
Received: from ns.suse.de ([213.95.15.193]:47632 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S285473AbRLSUTw>;
	Wed, 19 Dec 2001 15:19:52 -0500
Date: Wed, 19 Dec 2001 21:19:50 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Flavio Stanchina <flavio.stanchina@tin.it>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.17-rc2 oopses when unloading hid.o
In-Reply-To: <20011219200605.ISMI15319.fep23-svc.tin.it@there>
Message-ID: <Pine.LNX.4.33.0112192118230.26043-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.33.0112192118232.26043@Appserv.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Dec 2001, Flavio Stanchina wrote:

>  EIP:    0010:[devfs_put+48/224]    Tainted: PF
                                      ^^^^^^^^^^^
...
> Configuration is attached. Relevant things:
> devfs, usb-uhci + usb core built-in, hid as a module.

And what proprietory modules were loaded ?
Can you repeat the problem without them?

Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

