Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbUARN2b (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 08:28:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261298AbUARN2b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 08:28:31 -0500
Received: from mail.logiccontrol.es ([195.76.168.52]:12214 "EHLO
	mail.logiccontrol.es") by vger.kernel.org with ESMTP
	id S261262AbUARN2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 08:28:30 -0500
From: Pedro Larroy <piotr@member.fsf.org>
Reply-To: piotr@member.fsf.org
Organization: larroy.com
To: linux-kernel@vger.kernel.org
Subject: Re: [2.6.1 MCE falseness?] Hardware reports non-fatal error
Date: Sun, 18 Jan 2004 14:30:48 +0100
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401181430.48997.piotr@member.fsf.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I also have been getting apparently false MCEs since 2.5.xx 
I even had kernel panics in early 2.5 with MCE enabled. Now in 2.6.0-xx
and in 2.6.1 I just get them from time to time but none fatal.
most of the time in CPU 0

request_module: failed /sbin/modprobe -- char-major-6-0. error = 256
MCE: The hardware reports a non fatal, correctable incident occurred on CPU 0.
Bank 0: e606200000000833
request_module: failed /sbin/modprobe --

the box is dual athlon mp with AMD 760MP chipset.


nebula:/home/piotr# ./parsemce b 1 -a 0 -e e606200000000833
Status: (e606200000000833) Error IP valid
Restart IP valid.
nebula:/home/piotr#




-- 
  Pedro Larroy Tovar  |  piotr%member.fsf.org 

Software patents are a threat to innovation in Europe please check: 
	http://www.eurolinux.org/     

