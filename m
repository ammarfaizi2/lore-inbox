Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129047AbQKNTqX>; Tue, 14 Nov 2000 14:46:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129551AbQKNTqD>; Tue, 14 Nov 2000 14:46:03 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:10758 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129079AbQKNTp7>; Tue, 14 Nov 2000 14:45:59 -0500
Message-ID: <3A118E7F.462BAC34@timpanogas.org>
Date: Tue, 14 Nov 2000 12:11:59 -0700
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: NetWare Changing IP Port 524
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Petr/Linux,

If you are relying on port 524 to get SAP information for NCPFS over
TCPIP, you may want to track this since it appears Novell will be
patching this port to close a security flaw.  I 
added the tracking URL so you can review what changes they are
proposing.  I think what they
are proposing as an immediate patch may break NCPFS -- you will need to
check.

:-)

Jeff 

Novell NetWare discloses system information

Novell's NetWare operating system contains a flaw that allows 
system information to be leaked via TCP port 524 in pure IP 
configurations. When NetWare is used in a mix Microsoft 
environment, the Novell operating system leaks data via Service 
Advertising Protocol (SAP). Other third-party applications 
compound the problem as well. A hacker can use the data to gain 
knowledge on the inner workings of the affected system. It is 
recommended that port 524 be blocked to prevent any leaks. For 
more information on SAP:
http://support.novell.com/cgi-bin/search/search.pl?database_name=kb&type=HTM
L&docid=%03%21F221133%3a973867389%3a%20%28%2010050864%20%29%20%20%07%01%00&b
yte_count=71624


**********
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
