Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261635AbUJaO52@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261635AbUJaO52 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 09:57:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261638AbUJaO52
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 09:57:28 -0500
Received: from chello083144090118.chello.pl ([83.144.90.118]:32775 "EHLO
	plus.ds14.agh.edu.pl") by vger.kernel.org with ESMTP
	id S261635AbUJaO5J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 09:57:09 -0500
From: =?utf-8?q?Pawe=C5=82_Sikora?= <pluto@pld-linux.org>
To: linux-kernel@vger.kernel.org
Subject: unit-at-a-time...
Date: Sun, 31 Oct 2004 15:57:00 +0100
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410311557.00839.pluto@pld-linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

/i386/Makefile:# Disable unit-at-a-time mode, it makes gcc use a lot morestack
/i386/Makefile:CFLAGS += $(call cc-option,-fno-unit-at-a-time)

/x86_64/Makefile:# -funit-at-a-time shrinks the kernel .text considerably
/x86_64/Makefile:CFLAGS += $(call cc-option,-funit-at-a-time)

Which solution is correct?

-- 
/* Copyright (C) 2003, SCO, Inc. This is valuable Intellectual Property. */

                           #define say(x) lie(x)
