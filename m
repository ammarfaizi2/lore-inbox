Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262404AbTJITOh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 15:14:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262405AbTJITOh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 15:14:37 -0400
Received: from mailgate.pit.comms.marconi.com ([169.144.68.6]:44750 "EHLO
	mailgate.pit.comms.marconi.com") by vger.kernel.org with ESMTP
	id S262404AbTJITOg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 15:14:36 -0400
Message-ID: <313680C9A886D511A06000204840E1CF40BA49@whq-msgusr-02.pit.comms.marconi.com>
From: "Punj, Arun" <Arun.Punj@marconi.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Cc: "Punj, Arun" <Arun.Punj@marconi.com>
Subject: kernel stack size
Date: Thu, 9 Oct 2003 15:14:32 -0400 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Folks,

I am using 2.4.20 on a pentium with 256M ram. I am calling a 
function fxxx() in the user_mode, which results in an 
ioctl to a driver in kernel space. The function which handles
this function is k_fxx(), and this function calls some other
nested functions. IMHO somewhere in this call thread the stack
overflows and the process [which called fxxx] coredumps. How can 
I verify this hypothesis ? Is it possible to change the size of
the kernel for user process? can I set it per process ?

Please cc: Arun.Punj@marconi.com in your replies.

thanks
Arun
