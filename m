Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264896AbRFTPPy>; Wed, 20 Jun 2001 11:15:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264897AbRFTPPp>; Wed, 20 Jun 2001 11:15:45 -0400
Received: from hera.cwi.nl ([192.16.191.8]:61149 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S264896AbRFTPPf>;
	Wed, 20 Jun 2001 11:15:35 -0400
Date: Wed, 20 Jun 2001 17:15:33 +0200 (MET DST)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200106201515.RAA344053.aeb@vlet.cwi.nl>
To: linux-kernel@vger.kernel.org
Subject: gendisk stuff
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On ftp.kernel.org under kernel/people/aeb two files
03-2.4.6pre3-remove-real_devices and 04-2.4.6pre3-remove-max_p
that remove the fields real_devices and max_p from a struct gendisk
(and initialize such structs with the field: syntax).
The patches could be applied today, except that probably the
definition of the struct itself should stay unchanged in case
it is used in modules that live outside the kernel.

Andries
