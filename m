Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263434AbTKJNQx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 08:16:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263479AbTKJNQx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 08:16:53 -0500
Received: from ns.km0938.keymachine.de ([62.141.48.247]:45250 "EHLO
	km0938.keymachine.de") by vger.kernel.org with ESMTP
	id S263434AbTKJNQw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 08:16:52 -0500
Message-ID: <3FAF8FE0.30908@ng.h42.de>
Date: Mon, 10 Nov 2003 14:17:20 +0100
From: Lars Ehrhardt <1103@ng.h42.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Compiling 2.6.0-test9 with Stack Overflow Detection Support fails
 on sparc64
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

trying to compile kernel 2.6.0-test9 with the Stack Overflow Detection
Support option set to yes does not work on sparc64 gcc version 3.3.2
(Debian).

The output from make is:

CC      scripts/empty.o
gcc: -pg and -fomit-frame-pointer are incompatible
make[1]: *** [scripts/empty.o] Error 1
make: *** [scripts] Error 2

Kind regards

Lars Ehrhardt

