Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311874AbSCTRbf>; Wed, 20 Mar 2002 12:31:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311872AbSCTRbZ>; Wed, 20 Mar 2002 12:31:25 -0500
Received: from relay.uni-heidelberg.de ([129.206.100.212]:49060 "EHLO
	relay.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id <S311868AbSCTRbN>; Wed, 20 Mar 2002 12:31:13 -0500
Message-Id: <200203201731.g2KHVBM25553@fubini.pci.uni-heidelberg.de>
Content-Type: text/plain;
  charset="iso-8859-15"
From: Bernd Schubert <bernd-schubert@web.de>
To: <linux-kernel@vger.kernel.org>
Subject: http://kgdb.sourceforge.net/
Date: Wed, 20 Mar 2002 18:31:10 +0100
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo Jörg,

ist vielleicht auch für Dich interessant:

Introduction 

kgdb is a source level debugger for linux kernel.  It is used along with gdb 
to debug linux kernel. Kernel developers can debug a kernel similar to 
application programs with use of kgdb. It makes it possible to place 
breakpoints in kernel code, step through the code and observe variables. 

Two machines are required for using kgdb. One of these machines is a 
development machine and the other is a test machine. The machines are 
connected through a serial line, a null-modem cable which connects their 
serial ports.  The kernel to be debugged runs on the test machine. gdb runs 
on the development machine. The serial line is used by gdb to communicate to 
the kernel being debugged. 

kgdb is a kernel patch. It has to be applied to a linux kernel to enable 
kernel debugging.  kgdb patch adds following components to a kernel 

 gdb stub - The gdb stub is heart of the debugger. It is the part that 
handles requests comming from gdb on the developement machine. It has control 
of all processors in the target machine when kernel running on it is inside 
the debugger.
 modifications to fault handlers - Kernel gives control to debugger when an 
unexpected fault fault occurs. A kernel which does not contain gdb panics on 
unexpected faults. Modifications to fault handles allow kernel developers to 
analyze unexpected faults.
 serial communication - This component uses a serial driver in the kernel and 
offers an interface to gdb stub in the kernel. It is responsible for sending 
and recieving data from a serial line. This component is also responsible for 
handling control break request sent by gdb. kgdb is available for x86 
architecture on linux kernel 2.4.6 Please go to downloads page for getting 
it. 

http://kgdb.sourceforge.net/
