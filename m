Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264854AbTFCJNO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 05:13:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264855AbTFCJNO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 05:13:14 -0400
Received: from d12lmsgate-3.de.ibm.com ([194.196.100.236]:60336 "EHLO
	d12lmsgate-3.de.ibm.com") by vger.kernel.org with ESMTP
	id S264854AbTFCJNM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 05:13:12 -0400
Importance: Normal
Sensitivity: 
Subject: Re: sys_lookup_dcookie on s390
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OFB6EC5BCF.26B6C560-ONC1256D3A.0030FEB2@de.ibm.com>
From: "Martin Schwidefsky" <schwidefsky@de.ibm.com>
Date: Tue, 3 Jun 2003 11:22:32 +0200
X-MIMETrack: Serialize by Router on D12ML016/12/M/IBM(Release 5.0.9a |January 7, 2002) at
 03/06/2003 11:23:29
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Pete,

> Are you going to assign a number for lookup_dcookie? If yes, when?

You can use 110 for lookup_dcookie (reusing i386 specific iopl number that
have always been unused for s390). Never came around porting the oprofile
stuff to s390. Do you plan to do it ?

blue skies,
   Martin


