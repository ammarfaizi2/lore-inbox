Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261748AbSKCLiV>; Sun, 3 Nov 2002 06:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261749AbSKCLiV>; Sun, 3 Nov 2002 06:38:21 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:39694 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S261748AbSKCLiU>; Sun, 3 Nov 2002 06:38:20 -0500
Message-Id: <200211031139.gA3Bdtp27867@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: linux-kernel@vger.kernel.org
Subject: Oh no, local symbols in discarded section .exit.text _again_ :)
Date: Sun, 3 Nov 2002 14:31:53 -0200
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got well-known

drivers/built-in.o(.data+0xa6b4): undefined reference to
`local symbols in discarded section .exit.text'

There was some tool (by Keith Owens AFAIK) to find in which *.c
did that happen, can somebody point me to it?
--
vda
