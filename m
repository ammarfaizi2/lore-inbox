Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280666AbRKUBmD>; Tue, 20 Nov 2001 20:42:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281124AbRKUBln>; Tue, 20 Nov 2001 20:41:43 -0500
Received: from davinci.artisan.calpoly.edu ([129.65.60.31]:50954 "EHLO
	davinci.artisan.calpoly.edu") by vger.kernel.org with ESMTP
	id <S280666AbRKUBlj> convert rfc822-to-8bit; Tue, 20 Nov 2001 20:41:39 -0500
From: mroth@calpoly.edu
X-OpenMail-Hops: 1
Date: Tue, 20 Nov 2001 17:41:32 -0800
Message-Id: <H00006040937765d.1006306811.davinci.artisan.calpoly.edu@MHS>
Subject: Spawning kernel threads from other kernel threads(?)
MIME-Version: 1.0
TO: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Disposition: inline
	;Creation-Date="Tue, 20 Nov 2001 17:40:10 -0800"
	;Modification-Date="Tue, 20 Nov 2001 17:41:32 -0800"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Question:
	Can you spawn a kernel thread from another kernel thread? I want to 
have one manager “entity” which will dynamically create kernel threads as 
needed. Right now, when I try to spawn another thread from the manager “entity” 
[as of today, still a kernel thread] it will crash. Is this legal? If not, what 
is the alternative? 

kernel_thread() 
Kernel Version 2.4.3 

