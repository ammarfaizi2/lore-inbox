Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264036AbTDJMnJ (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 08:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264037AbTDJMnJ (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 08:43:09 -0400
Received: from mailproxy.de.uu.net ([192.76.144.34]:20929 "EHLO
	mailproxy.de.uu.net") by vger.kernel.org with ESMTP id S264036AbTDJMnI (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 08:43:08 -0400
Message-ID: <7A5D4FEED80CD61192F2001083FC1CF9065167@CHARLY>
From: "Filipau, Ihar" <ifilipau@sussdd.de>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: gdb on 2.2/2.4
Date: Thu, 10 Apr 2003 14:52:35 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="koi8-r"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

  [ CC me please - I'm not subscribed ]

  Couple of issues. I hope RH8 kernels not much /patched/ 
  comparing to vanilla in this respect.

  1. gdb doesn't work on 2.4 - if app got SIGSEGV - I cannot see
     backtrace of random thread. I have mutli-threaded app - but 
     gdb cannot access any other thread - only main thread.

  2. on 2.4 + ptrace() security fix, gdb on signal prints error 
     message: "Couldn't access registers: permission denied".
     and sure only 'quit' works correctly after this.

  In both cases it is run from user account.

  Does any-one has any clue how to make gdb working on rh8?
  I have tried to use vanilla kernel - but have no succes to 
  date...

  I'm not much about debugging - but finding a 
  SIGSEGV/SIGILL source is much more faster with gdb.

P.S. System: SMP/PIII (Tried in both smp/nosmp), RH8 std kernel, 
     RH8 updated kernel, 2.4.20. gcc 3.2/3.2.2, gdb 5.3.

--- Regards&Wishes! With respect  Ihar "Philips" Filipau, and Phil for
friends

- - - - - - - - - - - - - - - - - - - - - - - - -
MCS/Mathematician - System Programmer
Ihar Filipau 
Software entwickler @ SUSS MicroTec Test Systems GmbH, 
Suss-Strasse 1, D-01561 Sacka (bei Dresden)
e-mail: ifilipau@sussdd.de  tel: +49-(0)-352-4073-327
fax: +49-(0)-352-4073-700   web: http://www.suss.com/
