Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130063AbRBZAhp>; Sun, 25 Feb 2001 19:37:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130064AbRBZAhf>; Sun, 25 Feb 2001 19:37:35 -0500
Received: from shell.ca.us.webchat.org ([216.152.64.152]:57530 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S130063AbRBZAh3>; Sun, 25 Feb 2001 19:37:29 -0500
Message-ID: <030d01c09f8c$e01b57a0$7c4cf9d1@geeksparadise.com>
Reply-To: "davids" <davids@webmaster.com>
From: "davids" <davids@webmaster.com>
To: "Adam Fritzler" <mid@earth.zigamorph.net>, <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.21.0102250925230.26932-100000@earth.zigamorph.net>
Subject: Re: Core dumps for threads
Date: Sun, 25 Feb 2001 16:36:17 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> It does work, however. It effectively dumps the thread that caused the
> fault.

    If you want that behavior, catch SIGSEGV, fork, and have the child
process (in which only the faulting thread exists) call abort.

    DS


