Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267609AbTBFUAp>; Thu, 6 Feb 2003 15:00:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267612AbTBFUAp>; Thu, 6 Feb 2003 15:00:45 -0500
Received: from hera.cwi.nl ([192.16.191.8]:44709 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S267609AbTBFUAl>;
	Thu, 6 Feb 2003 15:00:41 -0500
From: Andries.Brouwer@cwi.nl
Date: Thu, 6 Feb 2003 21:10:18 +0100 (MET)
Message-Id: <UTC200302062010.h16KAIH23613.aeb@smtp.cwi.nl>
To: linux-kernel@vger.kernel.org
Subject: syscall documentation (4)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The next new page is gettid(2).

Comments welcome.
Andries
aeb@cwi.nl

----------------------------------- 
GETTID(2)           Linux Programmer's Manual           GETTID(2)

NAME
       gettid - get thread identification

SYNOPSIS
       #include <sys/types.h>
       #include <linux/unistd.h>

       _syscall0(pid_t,gettid)

       pid_t gettid(void);

DESCRIPTION
       gettid  returns the thread ID of the current process. This
       is equal to the process ID  (as  returned  by  getpid(2)),
       unless  the  process is part of a thread group (created by
       specifying the CLONE_THREAD flag to  the  clone(2)  system
       call).  All  processes  in  the same thread group have the
       same PID, but each one has a unique TID.

CONFORMING TO
       gettid is Linux specific and should not be  used  in  pro­
       grams that are intended to be portable.

SEE ALSO
       getpid(2), clone(2), fork(2)

Linux 2.4.20                2003-02-01                  GETTID(2)
