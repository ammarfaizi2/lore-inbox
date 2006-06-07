Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932431AbWFGWGQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932431AbWFGWGQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 18:06:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932434AbWFGWGQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 18:06:16 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:18243 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932431AbWFGWGP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 18:06:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id:from;
        b=sWoToZmCwe/2DKtZOhbFiWF+lnMDde3wjofvroRll3kFVkrMHnOAm9AGEIN1xZsrq0UwWVRnHSWAcX/YGcaRSmhB6ed1dOF7+C3dweArRQlrjXYfm/BiCbpFSxbXDi6Xm7BQqYnaEohIn+x5KfOpsNIW2YWHclJFqYdFpy9sCws=
To: linux-kernel@vger.kernel.org
Subject: Automatic bug hunting
Date: Thu, 8 Jun 2006 00:09:04 +0200
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606080009.06089.raigengo@yahoo.es>
From: Jordi <mumismo@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Related with the recent times _perceived_  increase in the number of bugs of 
the Kernel. I have found the following website:
http://scan.coverity.com/

They use automatic statis source code test for a number of projects including 
the Linux kernel.

I've not registered so I don't know what kind of bugs have been found but it's 
very unlikely that they have found "I don't have the hardware to fix this" 
kind of bugs. They surely are clear bugs, similar to those found by the 
automatic test for locking problems. 

I think this is a good source to check before doing a stable release. Unlikely  
human's bugs report, those report should be clear enought. We may aim for 
being "coverity free" before each major version (check it before 2.6.17).

--
Jordi Polo
