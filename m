Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261301AbTCXXkp>; Mon, 24 Mar 2003 18:40:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261302AbTCXXko>; Mon, 24 Mar 2003 18:40:44 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:6303 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261301AbTCXXko> convert rfc822-to-8bit;
	Mon, 24 Mar 2003 18:40:44 -0500
Content-Type: text/plain; charset=US-ASCII
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Duncan Sands <baldrick@wanadoo.fr>,
       Spang Oliver <oliver.spang@siemens.com>
Subject: Re: 2.5.64 ttyS problem ?
Date: Mon, 24 Mar 2003 15:46:27 -0800
User-Agent: KMail/1.4.1
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
References: <AEEEEE93AFA5D411AF8500D0B75E4A16062A4675@BSL203E> <200303241617.01952.baldrick@wanadoo.fr>
In-Reply-To: <200303241617.01952.baldrick@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200303241546.27384.pbadari@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 24 March 2003 07:17 am, Duncan Sands wrote:
> > has anyone another solution? I tried 2.5.62 to 2.5.65, same result.
>
> Is this the no "serial" module problem?  It seems to have been renamed
> "8250", but not everything knows that yet...
>
> Duncan.

[root@elm3b81 linux-2.5.64-gcov]# minicom
Device /dev/ttyS1 lock failed: No child processes.

[root@elm3b81 linux-2.5.64-gcov]# grep 8250 .config
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
# CONFIG_SERIAL_8250_CS is not set
# CONFIG_SERIAL_8250_EXTENDED is not set
# Non-8250 serial port support

- Badari
