Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262367AbTCMOqZ>; Thu, 13 Mar 2003 09:46:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262368AbTCMOqZ>; Thu, 13 Mar 2003 09:46:25 -0500
Received: from hal-4.inet.it ([213.92.5.23]:23458 "EHLO hal-4.inet.it")
	by vger.kernel.org with ESMTP id <S262367AbTCMOqY> convert rfc822-to-8bit;
	Thu, 13 Mar 2003 09:46:24 -0500
Content-Type: text/plain; charset=US-ASCII
From: Paolo Ornati <javaman@katamail.com>
To: linux-kernel@vger.kernel.org
Subject: "make clean": how it's needed?
Date: Thu, 13 Mar 2003 15:56:07 +0100
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20030313144624Z262367-25575+29577@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have this doubt, the "standard" procedure to build a kernel(2.2.x/2.4.x) is:
	make menuconfig
	make dep
	make clean	// ... when?
	make modules
	make bzImage
	...

so, when I really _MUST_ run "make clean"?
	always?
	only after that I have applied a patch?

I think that many old "*.o" files are still good... and so, why I should 
recompile them every time?

Bye,
	Paolo

