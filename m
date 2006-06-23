Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750764AbWFWO1g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750764AbWFWO1g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 10:27:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750774AbWFWO1g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 10:27:36 -0400
Received: from nz-out-0102.google.com ([64.233.162.194]:32889 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750764AbWFWO1g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 10:27:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=cGFeRzzQUrDQY9RMwFmgybCrgt0LhFDTOd66nltWLN8IvAhCSjZKT9iHPV2lX2dBDxTzCLyqFlkQHOM1PYUKtWWbpfdFRJNRVwA4NDfeM2glxyfeub0yK5i+TzmyPmOLDTSo34Le95izfjYPwVmVXTN/Hqib1FKEjyoegtMOBTg=
Message-ID: <9e4733910606230727s6e78b611m8a239ad8102438e@mail.gmail.com>
Date: Fri, 23 Jun 2006 10:27:35 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: EDAC: unable to reserve PCI region
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't know anything about how EDAC works, but this doesn't look
right. I would not have expected a PCI memory reservation to fail if
everything was set up right.

EDAC MC: Ver: 2.0.0 Jun  6 2006
EDAC i82875p: i82875p init one
PCI: Unable to reserve mem region #1:1000@fecf0000 for device 0000:00:06.0
EDAC MC0: Giving out device to "i82875p_edac" i82875p: PCI 0000:00:00.0

using 2.6.17

I don't have a device 0000:00:06.0 in /sys/bus/pci/devices either.
Shouldn't there be an entry there if I have this hardware?

Looks like my EDAC isn't functioning, I used have entries for it in sysfs.

-- 
Jon Smirl
jonsmirl@gmail.com
