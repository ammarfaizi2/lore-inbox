Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261452AbUKHIOe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261452AbUKHIOe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 03:14:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261774AbUKHIOe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 03:14:34 -0500
Received: from postino4.roma1.infn.it ([141.108.26.24]:52130 "EHLO
	postino4.roma1.infn.it") by vger.kernel.org with ESMTP
	id S261452AbUKHIO1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 03:14:27 -0500
Subject: isa memory address
From: Antonino Sergi <Antonino.Sergi@roma1.infn.it>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1099901664.2718.92.camel@delphi.roma1.infn.it>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 08 Nov 2004 09:14:24 +0100
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira Milter 1.0.6; VAE 6.28.0.12; VDF 6.28.0.59
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm working with an old data acquisition system that uses an 8-bit card
in an ISA slot (address 0xd0000), by a simple driver I ported from
kernel 1.1.x to 2.2.24.

It works fine, but I'd like to have features by newer kernels (2.4 or
even 2.6), like new filesystems support.

On kernels >=2.4.0 check_region returns -EBUSY for that address,
but it is not actually used; I tried to understand if something has been
changed/removed, because of obsolescence of devices, in IO management,
but I couldn't.

Does anybody have any explanation/suggestion?

Thank you

Best Regards,

Antonino Sergi

PS:As I'm not subscribed, please CC me your answers.


Antonino Sergi <Antonino.Sergi@Roma1.INFN.it>

Radiodating Laboratory
Physics Department
University of Rome "La Sapienza"
P.le Aldo Moro 2
00185 Rome Italy
Tel +390649914206
Fax +390649914208


