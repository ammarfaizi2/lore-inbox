Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267894AbRGVEGC>; Sun, 22 Jul 2001 00:06:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267895AbRGVEFx>; Sun, 22 Jul 2001 00:05:53 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:3849 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S267894AbRGVEFj>;
	Sun, 22 Jul 2001 00:05:39 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Stefan Becker <stefan@oph.rwth-aachen.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] init/main.c 
In-Reply-To: Your message of "Sun, 22 Jul 2001 05:58:15 +0200."
             <Pine.LNX.4.21.0107220556310.6416-100000@die-macht> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 22 Jul 2001 14:05:39 +1000
Message-ID: <2566.995774739@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Sun, 22 Jul 2001 05:58:15 +0200 (CEST), 
Stefan Becker <stefan@oph.rwth-aachen.de> wrote:
>Sorry, but I thought that even if a driver is built as a module the
>corresponding CONFIG_* symbol is defined.

CONFIG_foo=    CONFIG_foo     CONFIG_foo_MODULE
   n             undef             undef
   y               1               undef
   m             undef               1

