Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129211AbQKMOvF>; Mon, 13 Nov 2000 09:51:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129425AbQKMOuy>; Mon, 13 Nov 2000 09:50:54 -0500
Received: from gate.intermec.com ([204.57.247.20]:24746 "EHLO intermec.com")
	by vger.kernel.org with ESMTP id <S129211AbQKMOun> convert rfc822-to-8bit;
	Mon, 13 Nov 2000 09:50:43 -0500
From: <Daniel.Deimert@intermec.com>
Message-ID: <E36790918FA6D411856500508BD3B2CA1B21@eusegotmail1b.eu.intermec.com>
To: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
Cc: alan@redhat.com
Subject: PROBLEM: 2.2.18pre17 nfs - mount/showmount failed
Date: Mon, 13 Nov 2000 05:58:37 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

LINUX KERNEL PROBLEM REPORT

[1.] 2.2.18pre17 knfsd stops replying to mount or showmount requests

[2.] Full description of the problem:

After 9 days of uptime, Linux 2.2 clients could no longer mount nfs shares
from a 2.2.18pre17 server.
The client mount request was logged as authenticated by syslog, but the
client was denied access.
Running "showmount" on the server responded with a RPC error. No "dump"
request was logged to
syslog.  "rpcinfo -p localhost" showed mountd to be registered.
Restarting nfs with "service nfs restart" gave an error message when
shutting down mountd, but the restart restored things to normal.

[3.] Keywords: nfs, mountd, showmount

[4.] Kernel version: 2.2.18pre17

[5.] Output of Oops... message 
	N/A

[6.] Example program to trigger problem
	N/A

[7] Environment:

Red Hat 6.2
server running 2.2.18pre17 and nfs-utils 0.2
clients running RH 2.2.16

[X.]  Other notes:


--- 
Daniel Deimert (daniel.deimert@intermec.com)
Intermec Printers AB, Göteborg, Sweden



 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
