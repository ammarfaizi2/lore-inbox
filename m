Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263228AbTJPVmR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 17:42:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263152AbTJPVmR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 17:42:17 -0400
Received: from toulouse-4-a7-62-147-200-227.dial.proxad.net ([62.147.200.227]:50560
	"EHLO albireo.free.fr") by vger.kernel.org with ESMTP
	id S263228AbTJPViw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 17:38:52 -0400
Message-Id: <200310162139.h9GLd8XD004908@albireo.free.fr>
Date: Thu, 16 Oct 2003 23:39:08 +0200 (CEST)
From: frahm@irsamc.ups-tlse.fr
Reply-To: frahm@irsamc.ups-tlse.fr
Subject: Re: usb-storage kills lilo (2.6-test[67])
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think that this problem is related to the bug that the scsi-device 
moves from sda to sdb, sdc etc. when removing and inserting a memory
stick. I have applied a patch from Patrick Mansfield 
at 

 http://marc.theaimsgroup.com/?l=linux-kernel&m=106580260717355&w=2

which solves both the changing of the scsi-device and the lilo-problem 
for 2.6-test7. 

It seems that this patch is already in the bk-tree so that you can 
use 2.6-test7-bk8 or wait for 2.6-test8.


Greetings,

Klaus Frahm.

