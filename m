Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316422AbSE3GvD>; Thu, 30 May 2002 02:51:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316423AbSE3GvC>; Thu, 30 May 2002 02:51:02 -0400
Received: from goliath.siemens.de ([192.35.17.28]:26013 "EHLO
	goliath.siemens.de") by vger.kernel.org with ESMTP
	id <S316422AbSE3GvB>; Thu, 30 May 2002 02:51:01 -0400
Message-ID: <6134254DE87BD411908B00A0C99B044F037F72F5@mowd019a.mow.siemens.ru>
From: Borsenkow Andrej <Andrej.Borsenkow@mow.siemens.ru>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Decoding of addreses in kernel logs 
Date: Thu, 30 May 2002 10:57:50 +0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Are there any cases except oopses when decoding of addresses in kernel logs
is needed? The reason is I'd like to switch from klogd+syslogd to other
logging system and I was adviced to forget klogd and just get logs from
/proc/kmsg and decode them with ksymoops. While I have no problem with it
actually, my concern is - is it possible that some information in kernel
logs can be decoded by klogd but not by ksymoops?

Thank you

-andrej
