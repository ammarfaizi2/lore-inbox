Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262690AbVA0RxA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262690AbVA0RxA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 12:53:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262682AbVA0Rws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 12:52:48 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:14811 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262690AbVA0RwN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 12:52:13 -0500
Message-ID: <41F92A48.2010100@watson.ibm.com>
Date: Thu, 27 Jan 2005 12:52:08 -0500
From: Shailabh Nagar <nagar@watson.ibm.com>
Reply-To: nagar@watson.ibm.com
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ckrm-tech <ckrm-tech@lists.sourceforge.net>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: ckrm-e17
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Version e17 of the Class-based Kernel Resource Management
is now available for download from

http://sourceforge.net/project/showfiles.php?group_id=85838&package_id=94608
	
The major updates since the previous version include:
1. Numerous bugfixes
2. Control over rate of process forks through the numtasks controller.
The rate of forking is a single systemwide parameter affecting all 
classes. Existing share-based control over total number of forks allowed 
per class remains the same.
3. Interface change: The "target" file has been removed from the RCFS 
interface. The same functionality can now be obtained by writing to the 
"members" file of any class.

Files released:

ckrm-e17.2610.patch
	Combined patch against 2.6.10. Includes the numtasks and 		 
listenaq controllers.
e17-incr.tar.bz2
	Tarball of broken down patches. First 10 patches constitute
	the e16 release and subsequent ones contain the updates since
	then.
cpu.ckrm-e17.v10.patch
	CPU controller.


Still to come:

memory controller
I/O controller
test packages


Please note that updates to CKRM based on the feedback from lkml on
the previous release (http://lkml.org/lkml/2004/11/29/152) are in 
progress and will be included in the next release.

Testing and feedback welcome.

--Shailabh






