Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264091AbTFPSxx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 14:53:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264151AbTFPSxx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 14:53:53 -0400
Received: from nix.ll.pl ([212.14.58.10]:24193 "HELO nix.ll.pl")
	by vger.kernel.org with SMTP id S264091AbTFPSxv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 14:53:51 -0400
Message-ID: <00d801c3343a$9452aea0$083a0ed4@deltav>
From: "Robert Grzelak" <rg@nix.ll.pl>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.21 oops second time
Date: Mon, 16 Jun 2003 21:07:49 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
X-AntiVirus: scanned for viruses by MKS_vir
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Welcome!
My colege Andrzej Sosnowski  in post "2.4.21 oops"
has write about error in kernel 2.4.21 in time of using this script
"#!/bin/sh
for IP in `/usr/bin/seq 3 500`; do
  ip addr add 3ffe:80ee:c1d::$IP/48 dev eth0
  ip addr add 3ffe:80ee:c1d::a:$IP/48 dev eth0
done"

I've made tests on clear kernel 2.4.21 in distributions:
debian 3.0r1 woody & Red Hat Linux release 8.0 (Psyche)
error kernel BUG sched.c 564! -  is showing while making this script.

At the latest version of kernel 2.4.20 this error does'nt exists.

I have been tested this kernel (2.4.21) also with patch 
grsecurity-1.9.10-2.4.21.patch.

It makes no difference - error shows again.

With best regards!
Robert Grzelak


