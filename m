Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263597AbTCUMLs>; Fri, 21 Mar 2003 07:11:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263598AbTCUMLs>; Fri, 21 Mar 2003 07:11:48 -0500
Received: from asplinux.ru ([195.133.213.194]:44537 "EHLO gem.asplinux.ru")
	by vger.kernel.org with ESMTP id <S263597AbTCUMLr>;
	Fri, 21 Mar 2003 07:11:47 -0500
Date: Fri, 21 Mar 2003 15:22:49 +0300
From: Maxim Giryaev <gem@asplinux.ru>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: hardware error handling in ext3
Message-ID: <20030321122249.GC9060@gem.asplinux.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.5 kernel calls journal_abort() in ext3_handle_error() in case of ERRORS_CONT since 1.35 version of fs/ext3/super.c.
Is this unexpected side effect or planned behaviour ?

Maxim Giryaev
