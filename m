Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263185AbTKXNPk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 08:15:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263310AbTKXNPk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 08:15:40 -0500
Received: from [65.248.4.67] ([65.248.4.67]:13998 "EHLO verdesmares.com")
	by vger.kernel.org with ESMTP id S263185AbTKXNPj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 08:15:39 -0500
Message-ID: <001001c3b28d$183400e0$34dfa7c8@bsb.virtua.com.br>
From: "Breno" <brenosp@brasilsec.com.br>
To: "Kernel List" <linux-kernel@vger.kernel.org>
Subject: Force Coredump
Date: Mon, 24 Nov 2003 11:15:51 -0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I need force a coredump file. So i tryed :

int *i = 0;
if(*i)
exit(1);

tryed to kill -11 'pid'
...

but i just received a seg. fault message, and doesn´t  create coredump file.

Anybody knows why ?
att
Breno

