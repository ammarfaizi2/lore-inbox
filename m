Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261737AbSKCLV1>; Sun, 3 Nov 2002 06:21:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261740AbSKCLV1>; Sun, 3 Nov 2002 06:21:27 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:33550 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S261737AbSKCLV0>; Sun, 3 Nov 2002 06:21:26 -0500
Message-Id: <200211031122.gA3BMbp27805@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Roman Zippel <zippel@linux-m68k.org>,
       Kai Germaschewski <kai-germaschewski@uiowa.edu>
Subject: 2.5: troubles with piping make output
Date: Sun, 3 Nov 2002 14:14:35 -0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My favorite way of running make is

make "$@" 2>&1 | tee --append !make.log

but in 2.5.45 it does not work. Removing '| tee ...'
part fixes it, but I'd like to retain the old way
for obvious reasons.
--
vda
