Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277656AbRJVFt3>; Mon, 22 Oct 2001 01:49:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277705AbRJVFtT>; Mon, 22 Oct 2001 01:49:19 -0400
Received: from gap.cco.caltech.edu ([131.215.139.43]:20352 "EHLO
	gap.cco.caltech.edu") by vger.kernel.org with ESMTP
	id <S277656AbRJVFtD> convert rfc822-to-8bit; Mon, 22 Oct 2001 01:49:03 -0400
Date: 22 Oct 2001 05:35:33 -0000
Message-ID: <20011022053533.3732.qmail@mailweb17.rediffmail.com>
MIME-Version: 1.0
From: "Dinesh  Gandhewar" <dinesh_gandhewar@rediffmail.com>
Reply-To: "Dinesh  Gandhewar" <dinesh_gandhewar@rediffmail.com>
To: kernelnewbies@nl.linux.org
Cc: mlist-linux-kernel@nntp-server.caltech.edu
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
A process makes a system call. It will go into kernel mode. Now the code of this system call is as follows.
while (1)
{  receive message from remote node ();
   process the message () ;
   send reply back to the remote node () ;
}
Suppose 1st function requires a blocking operation. What happens to this process and other processes in the system?
Is it that this process goes in wait state in kernel mode and other process gets scheduled. When the required event occurs the blocked process wakes up and waits for its chance to get executed.
Thanking you,
Dinesh.


  

