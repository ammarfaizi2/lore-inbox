Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265081AbTLRLbh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 06:31:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265094AbTLRLbh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 06:31:37 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:44476 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S265081AbTLRLbf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 06:31:35 -0500
Date: Thu, 18 Dec 2003 17:11:29 +0500
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: linux-diag-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, dsteklof@us.ibm.com, greg@kroah.com
Subject: [ANNOUNCE] libsysfs v0.4.0
Message-ID: <20031218121129.GA17422@in.ibm.com>
Reply-To: ananth@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Release 0.4.0 for libsysfs is now available at:

	http://linux-diag.sourceforge.net 

A number of changes have been made in this release which will 
require a few modifications to applications already using 
the library. (udev-009 already has a bulk of these changes).

Here are the important additions/changes:

	* Postponed reading directories and attributes until 
		absolutely necessary. 
	* Structure elements that are lists or references to 
		structures are not populated by default. APIs 
		have now been provided to populate them.
	* All "open" functions that take absolute path as argument
		now have a "_path" suffix.
	* Provided attribute "refresh" functions to read in updated
		attribute values.
	* Changes for klibc compatibility.
	* Provided APIs to retrieve device/class_device "parent".
	* Added manpages for lsbus and systool (Thanks to Martin Pitt).

Please visit http://linux-diag.sourceforge.net/Sysfsutils.html for 
more information.

Comments, suggestions welcome! 


Thanks,
Ananth
-- 
Ananth Narayan <ananth@in.ibm.com>
Linux Technology Center,
IBM Software Lab, INDIA

