Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262628AbREZKTP>; Sat, 26 May 2001 06:19:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262630AbREZKTF>; Sat, 26 May 2001 06:19:05 -0400
Received: from iproxy1.ericsson.dk ([130.228.248.98]:7564 "EHLO
	iproxy1.ericsson.dk") by vger.kernel.org with ESMTP
	id <S262628AbREZKS4>; Sat, 26 May 2001 06:18:56 -0400
Message-ID: <3B0F8248.F3644D79@fabbione.net>
Date: Sat, 26 May 2001 12:15:36 +0200
From: Fabbione <fabbione@fabbione.net>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH .. not really...][2.4.5] drivers/usb/ov511.c
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi gurus,
	this file does not compile.
I've probably found the solution but i'm totally not an expert and
nearly to able
to submit a normal patch... sorry...

in the function ov511_read_proc the line
out += sprintf (out, "driver_version  : %s\n", version);
report an error because version is not defined.

I've tryed in this way:
out += sprintf (out, "driver_version  : %s\n", DRIVER_VERSION);

this compile and seems to work....

Regards
Fabio
