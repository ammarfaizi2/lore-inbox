Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280814AbRKLPCL>; Mon, 12 Nov 2001 10:02:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280813AbRKLPCB>; Mon, 12 Nov 2001 10:02:01 -0500
Received: from mauve.demon.co.uk ([158.152.209.66]:12690 "EHLO
	mauve.demon.co.uk") by vger.kernel.org with ESMTP
	id <S280814AbRKLPBv>; Mon, 12 Nov 2001 10:01:51 -0500
From: Ian Stirling <root@mauve.demon.co.uk>
Message-Id: <200111121501.PAA14184@mauve.demon.co.uk>
To: linux-kernel@vger.kernel.org
Date: Mon, 12 Nov 2001 15:01:36 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A while back (2.2.*) it was possible to fake a network connection
coming down, by using for example sockdown, from the netpipes packae,
on sockets in /proc/nnn/fd/n.
This was very handy to avoid having to wait for a timeout, if something
bad happened to the server at the other end.
I've now tried it with 2.4, and find that it now doesn't work.
Is this a bug or a feature?

