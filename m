Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261819AbVCKW7k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261819AbVCKW7k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 17:59:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261849AbVCKW6v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 17:58:51 -0500
Received: from fmr20.intel.com ([134.134.136.19]:63915 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S261805AbVCKWul (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 17:50:41 -0500
Date: Fri, 11 Mar 2005 16:10:28 -0800
From: long <tlnguyen@snoqualmie.dp.intel.com>
Message-Id: <200503120010.j2C0AS4Q020291@snoqualmie.dp.intel.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: [PATCH 0/6] PCI Express Advanced Error Reporting Driver
Cc: greg@kroah.com, tom.l.nguyen@intel.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PCI Express error signaling can occur on the PCI Express link itself
or on behalf of transactions initiated on the link. PCI Express
defines the Advanced Error Reporting capability, which is implemented 
with a PCI Express advanced error reporting extended capability
structure, to provide more robust error reporting. With the Advanced
Error Reporting capability a PCI Express component, which detects an
error, can send an error message to the Root Port associated with
its hierarchy.  

The PCI Express Advanced Error Reporting driver is a PCI Express Bus's 
service driver to handle Advanced Error Reporting on Root Ports. The
PCI Express AER Root driver provides the following functions:

-	A mechanism to allow a driver of a PCI Express component to
	register/un-register its AER aware callback handle with the
	PCI Express AER Root driver. This mechanism is provided as
	an option to allow the PCI Express AER Root driver to query
	the PCI Express component device driver to determine more
	precisely which error and what severity occurred.
	
-	A mechanism to process the error reporting message detected
	by Root Ports, and 

-	Report the errors to user.

This patchset, which is based on Linux kernel 2.6.11-rc5, consists
of patches in numeric order as they should be applied.

[PATCH 1/6] <- first patch to be applied
[PATCH 2/6] <- second patch to be applied
[PATCH 3/6] <- third patch to be applied
[PATCH 4/6] <- fourth patch to be applied
[PATCH 5/6] <- fifth patch to be applied
[PATCH 6/6] <- last patch to be applied

Please send us any suggestions, feedback, comments or alternative
designs.

Signed-off-by: T. Long Nguyen <tom.l.nguyen@intel.com>

--------------------------------------------------------------------
