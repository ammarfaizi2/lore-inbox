Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268247AbTBNIx3>; Fri, 14 Feb 2003 03:53:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268248AbTBNIx3>; Fri, 14 Feb 2003 03:53:29 -0500
Received: from mailserv.intranet.GR ([146.124.14.106]:20355 "EHLO
	mailserv.intranet.gr") by vger.kernel.org with ESMTP
	id <S268247AbTBNIx2>; Fri, 14 Feb 2003 03:53:28 -0500
Subject: PROBLEM: in Config.in
From: Polychronis Ypodimatopoulos <ypol@intracom.gr>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1045213608.4604.13.camel@pcypol.intranet.gr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 14 Feb 2003 11:06:48 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

File: /usr/src/linux/drivers/char/Config.in, line 152:

if [ "$CONFIG_PPC64" ] ; then

should be

if [ "$CONFIG_PPC64" = "y" ] ; then

right?

Cheers

-- 
Polychronis Ypodimatopoulos
INTRACOM S.A.
Hellenic Telecommunications and Information Systems Industry
Markopoulou Ave.
190 02 Peania
Greece
Tel: +30 210 6679067
email: ypol@intracom.gr

