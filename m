Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275272AbTHNXUC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 19:20:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275367AbTHNXUC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 19:20:02 -0400
Received: from web11204.mail.yahoo.com ([216.136.131.186]:9318 "HELO
	web11204.mail.yahoo.com") by vger.kernel.org with SMTP
	id S275272AbTHNXUA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 19:20:00 -0400
Message-ID: <20030814231959.22781.qmail@web11204.mail.yahoo.com>
Date: Thu, 14 Aug 2003 16:19:59 -0700 (PDT)
From: Daniel Pezoa <dpforos@yahoo.com>
Subject: TOPDIR kernel variable
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Kernel Community !!  :-)

I'am compiling lirc software, the kernel source is
needed to make them, but when i attemt to make them it
fail because the environment variable TOPDIR is not
set, looking for the origin of the problem, the script
that fail is "pathdown.sh", one tiny script of the
kernel, it fails when is trying to assign
TP=${TOPDIR:). Reading more i found in the Kernel
Makefile the line 

TOPDIR := $(shell /bin/pwd)

that command should solve my problem but if i launch
them in the console, it give me the following errors
in the screen ouput:

bash: shell: command not found
bash: TOPDIR:=: command not found

What is the intention of the environment variable
TOPDIR and how can i give them a valid value?

Thanks for your help and Good luck!!  :-)

Daniel Pezoa


__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free, easy-to-use web site design software
http://sitebuilder.yahoo.com
