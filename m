Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261251AbUKNGnA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261251AbUKNGnA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 01:43:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261252AbUKNGnA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 01:43:00 -0500
Received: from smtp806.mail.sc5.yahoo.com ([66.163.168.185]:52830 "HELO
	smtp806.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261251AbUKNGm6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 01:42:58 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] raw1394: sysfs support via class_simple
Date: Sun, 14 Nov 2004 01:42:55 -0500
User-Agent: KMail/1.6.2
Cc: Daniel Drake <dsd@gentoo.org>, bcollins@debian.org,
       linux1394-devel@lists.sourceforge.net
References: <4196D308.60801@gentoo.org>
In-Reply-To: <4196D308.60801@gentoo.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200411140142.56071.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 13 November 2004 10:37 pm, Daniel Drake wrote:
> Adds basic sysfs support for udev etc.
> Ideally we should link into the ieee1394 sysfs class, but it doesn't seem 
> extensible in that manner.

Hmm, with the exception of raw1394, the rest of ieee1394 subsystem does
not need its own classes as 1394 devices hook up into other subsystems
(SCSI, NET) and are classified with the rest of the devices in those
systems. After all userspace does not really care whether eth0 is on
PCI, ISA or IEEE1394, all it needs to know that it is just another network
interface. Am I missing something?
 
> For now, class_simple will do.
> 
> Depends on the previous whitespace fix patch.
> 
> Signed-off-by: Daniel Drake <dsd@gentoo.org>
> 

-- 
Dmitry
