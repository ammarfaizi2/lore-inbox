Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264765AbUEJPoT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264765AbUEJPoT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 11:44:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264767AbUEJPoT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 11:44:19 -0400
Received: from smtp015.mail.yahoo.com ([216.136.173.59]:2918 "HELO
	smtp015.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264765AbUEJPoS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 11:44:18 -0400
Subject: ptrace in 2.6.5
From: Fabiano Ramos <ramos_fabiano@yahoo.com.br>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1084203979.1421.1.camel@slack.domain.invalid>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 10 May 2004 12:46:19 -0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All.

     Is ptrace(), in singlestep mode, required to stop after a int 0x80?
    When tracing a sequence like

	mov ...
	int 0x80
	mov ....

    ptrace would notify the tracer after the two movs, but not after the
int 0x80. I want to know if it is a bug or the expected behaviour.

TIA,
Fabiano

