Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264963AbRF1XMd>; Thu, 28 Jun 2001 19:12:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264838AbRF1XMX>; Thu, 28 Jun 2001 19:12:23 -0400
Received: from comverse-in.com ([38.150.222.2]:33279 "EHLO
	eagle.comverse-in.com") by vger.kernel.org with ESMTP
	id <S264848AbRF1XMQ>; Thu, 28 Jun 2001 19:12:16 -0400
Message-ID: <6B1DF6EEBA51D31182F200902740436802678FB5@mail-in.comverse-in.com>
From: "Khachaturov, Vassilii" <Vassilii.Khachaturov@comverse.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: RFC: Changes for PCI
Date: Thu, 28 Jun 2001 19:08:23 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jun 2001, Jeff Garzik wrote:
 
> However, I think the driver (only going by your 
description) would be
> more correct to use a pointer to struct pci_dev.  We have a 
token in the
> kernel that is guaranteed 100% unique to any given PCI device:  the
> pointer to its struct pci_dev.

Is it? With a hotplug device removed and another one added,
isn't there a slight chance that the pci_dev pointer to the new device
will get allocated in place of the old one?

Vassilii
