Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262107AbSJNTMq>; Mon, 14 Oct 2002 15:12:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262108AbSJNTMq>; Mon, 14 Oct 2002 15:12:46 -0400
Received: from steve.prima.de ([62.72.84.2]:5319 "HELO steve.prima.de")
	by vger.kernel.org with SMTP id <S262107AbSJNTMp>;
	Mon, 14 Oct 2002 15:12:45 -0400
Date: Mon, 14 Oct 2002 21:18:17 +0200
From: Patrick Mau <mau@oscar.prima.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.5.xx (BK current) hangs executing rpcinfo
Message-ID: <20021014191817.GA23212@oscar.homelinux.net>
Reply-To: Patrick Mau <mau@oscar.prima.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo List,

Debian Linux checks the availibility of NFS v3 by using

# rpcinfo -u localhost nfs 3

Kernel 2.4.18 immediatly returns successful, but current
2.5 BK kernels timeout in the sendto() syscall.

Could someone please verify this ? Is this a known problem ?
Both kernels have v3 server support enabled.

It would be very kind if someone could try the above an send
a reply to me, or tell me why it's not working.

thanks,
Patrick

