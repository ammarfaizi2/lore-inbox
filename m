Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129078AbQJ0GUE>; Fri, 27 Oct 2000 02:20:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129142AbQJ0GTy>; Fri, 27 Oct 2000 02:19:54 -0400
Received: from vger.timpanogas.org ([207.109.151.240]:45060 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129078AbQJ0GTn>; Fri, 27 Oct 2000 02:19:43 -0400
Message-ID: <39F91DAB.B7A242E@timpanogas.org>
Date: Fri, 27 Oct 2000 00:16:11 -0600
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: NCPFS flags all files executable on NetWare Volumes with NFS Namespace
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Petr/Linux,

I noticed NCPFS is flagging all the files on a native NetWare volume as
executable and chmod 
-x does not work, even if the NetWare server has the NFS namespace
loaded.  I looked at 
you code in more detail, and I did not see support their for the
NFS/Unix namespace.  

Is this in a newer version, or has it not been implemented yet?  I was
testing with MARS 
and Native NetWare this evening and saw this.  If the NFS namespace is
loaded, you should 
be able to get to it and access and set all these bits in the file
system namespace directory
records.

Do you need any info from me to get this working, or is there another
version where I can 
get this for Ute-Linux?

Thanks,

:-)

Jeff
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
