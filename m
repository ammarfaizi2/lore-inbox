Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289735AbSAOXQ5>; Tue, 15 Jan 2002 18:16:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289739AbSAOXQk>; Tue, 15 Jan 2002 18:16:40 -0500
Received: from aldebaran.sra.com ([163.252.31.31]:15102 "EHLO
	aldebaran.sra.com") by vger.kernel.org with ESMTP
	id <S289735AbSAOXQU>; Tue, 15 Jan 2002 18:16:20 -0500
From: David Garfield <garfield@irving.iisd.sra.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15428.47094.435181.278715@irving.iisd.sra.com>
Date: Tue, 15 Jan 2002 18:15:02 -0500
To: linux-kernel@vger.kernel.org
Subject: Query about initramfs and modules
X-Mailer: VM 6.96 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hearing all this talk about initramfs and eliminating hardwired
drivers, it occurs to me to ask:



Can/will the initramfs mechanism be made to implicitly load into the
kernel the modules (or some of the modules) in the image?



Doing so would allow the initramfs image to be composed solely of the
modules to be loaded, which would reduce the need for the "klibc".  It
would also eliminate the need for any sort of control script to be in
the image.

The only difficulty that I perceive in doing this is that the modules
in question might need to be appropriately resolved and relocated
before being put into the file image.  I think this is a solvable
problem, given that the kernel and its System.map should be available
when building the image.

--David Garfield
