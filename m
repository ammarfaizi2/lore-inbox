Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275853AbRJPKBz>; Tue, 16 Oct 2001 06:01:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275857AbRJPKBp>; Tue, 16 Oct 2001 06:01:45 -0400
Received: from dspnet.claranet.fr ([212.43.196.92]:14342 "HELO
	dspnet.fr.eu.org") by vger.kernel.org with SMTP id <S275853AbRJPKBa>;
	Tue, 16 Oct 2001 06:01:30 -0400
Date: Tue, 16 Oct 2001 12:02:01 +0200
From: Jean-Luc Leger <reiga@dspnet.fr.eu.org>
To: linux-kernel@vger.kernel.org
Subject: some bugs in preparsing directives
Message-ID: <20011016120201.S6667@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

here are some probable bugs :
(line numbers are from 2.4.12-ac3)

* drivers/telephony/ixj.c : unknown directive in line 390
-> should be #define

* drivers/acorn/scsi/ecoscsi.c : #endif missing at the end of file
-> the #if directive is in line 235

* drivers/scsi/dpt_i2o.c : Expression expected in #elif at lines 83 and 1804
->  "defined"

* drivers/media/video/planb.c : #endif unexpected out of an #if at line 69
-> line 67 should be "#else" (not #endif)

	JLL

