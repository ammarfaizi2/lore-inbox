Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262271AbVCBLed@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262271AbVCBLed (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 06:34:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262269AbVCBLec
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 06:34:32 -0500
Received: from ppsw-8.csi.cam.ac.uk ([131.111.8.138]:27070 "EHLO
	ppsw-8.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S262270AbVCBLeW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 06:34:22 -0500
Subject: Re: [PATCH] raw1394 missing failure handling
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Panagiotis Issaris <panagiotis.issaris@mech.kuleuven.ac.be>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <42259F3A.8000206@mech.kuleuven.ac.be>
References: <42259F3A.8000206@mech.kuleuven.ac.be>
Content-Type: text/plain
Organization: University of Cambridge Computing Service, UK
Date: Wed, 02 Mar 2005 11:33:52 +0000
Message-Id: <1109763232.12379.6.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 2005-03-02 at 12:10 +0100, Panagiotis Issaris wrote:
> In the raw1394 driver the failure handling for
> a __copy_to_user call is missing.

Your patch is obviously incorrect as it doesn't free the request before
it returns.

Best regards,

        Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

