Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279987AbRKNBkp>; Tue, 13 Nov 2001 20:40:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279982AbRKNBk0>; Tue, 13 Nov 2001 20:40:26 -0500
Received: from fes3.whowhere.com ([209.185.123.188]:1888 "HELO mailcity.com")
	by vger.kernel.org with SMTP id <S279980AbRKNBkW>;
	Tue, 13 Nov 2001 20:40:22 -0500
To: linux-kernel@vger.kernel.org
Date: Tue, 13 Nov 2001 19:40:08 -0600
From: "Donald Harter" <dharter@lycos.com>
Message-ID: <IPKBFBEEDJJJACAA@mailcity.com>
Mime-Version: 1.0
X-Sent-Mail: off
Reply-To: dharter@lycos.com
X-Mailer: MailCity Service
X-Priority: 3
Subject: Is this a kernel problem? segmentation fault
X-Sender-Ip: 65.81.180.208
Organization: Lycos Mail  (http://mail.lycos.com:80)
Content-Type: text/plain; charset=us-ascii
Content-Language: en
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

     I started by debugging this program where I was getting a segmentation fault.  I used gdb and traced the bug to a call instruction.  I dissasembled the code and stepped through the instructions.  The program  got a segmentation fault when it executed an assembly language call instruction. Using gdb I was able to disassemble the instructions at the called address. Why can gdb disasemble instructions at a call address and a call to that address fails with a segmentation fault?  Is this a kernel problem?  I am using kernel version 2.2.15.  Any suggestions would be appreciated. I tried kernel 2.4.4 and the same thing happens.  I have searched this mailing list archive and did find some posts about segmentation faults/ kernel bugs, but they did not resolve this problem.  I use egcs 1.1-2 and ld 2.9.5 versions.



