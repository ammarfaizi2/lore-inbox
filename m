Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263770AbUFNSr4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263770AbUFNSr4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 14:47:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263778AbUFNSr4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 14:47:56 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:44262 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S263770AbUFNSrz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 14:47:55 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: ngo giang <ngohoanggiang1981dh@yahoo.com>
Date: Mon, 14 Jun 2004 20:47:42 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-2
Content-transfer-encoding: 8BIT
Subject: Re: Error when build linux kernel
Cc: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <94D7F352A12@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 Jun 04 at 4:22, ngo giang wrote:
> machine and installed RedHat 8.0  as a guest operating
> system . I want to built kernel . I used kernel 2.4.3 
> and did follow : 
> # cp  linux-2.4.3.tar.gz  /home
> 
> but the compilation has error as follow : 
> 
> timer.c : 35 conflicting types for Åxtimeå
> /home/linux/include/linux/sched.h:540 : previous
> declaration of `xtime'

Kernel you are trying to build is incompatible with gcc you are trying
to use. Use 2.4.26 kernel, or use gcc which is approved for 2.4.3 kernel.
You cannot use gcc-3.3.3 for building 2.4.3 kernel...
                                                Petr Vandrovec
                                                                                        

