Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267958AbTBRTRa>; Tue, 18 Feb 2003 14:17:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267964AbTBRTR3>; Tue, 18 Feb 2003 14:17:29 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:21492 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267958AbTBRTR2>; Tue, 18 Feb 2003 14:17:28 -0500
Importance: Normal
Sensitivity: 
Subject: Re: [PATCH] Fix warnings from CIFS on 2.5.61
To: Stephen Hemminger <shemminger@osdl.org>
Cc: sfrench@samba.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailer: Lotus Notes Release 5.0.4a  July 24, 2000
Message-ID: <OF865305AC.FB1FEBF0-ON87256CD1.006A97BE@us.ibm.com>
From: Steven French <sfrench@us.ibm.com>
Date: Tue, 18 Feb 2003 13:26:33 -0600
X-MIMETrack: Serialize by Router on D03NM123/03/M/IBM(Release 6.0 [IBM]|December 16, 2002) at
 02/18/2003 12:27:01
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





Stephen Hemminger wrote:
>This patch gets rid of the following warnings.
>
>fs/cifs/cifssmb.c: In function `CIFSSMBRead':
>fs/cifs/cifssmb.c:489: warning: duplicate `const'

Your proposed patch is slightly better than what I had coded up to get rid
of the spurious gcc 3.2 warnings on the use of the min macro with const.  I
will include it as part of the next cifs update in the next few days.

Thanks.

Steve French
Senior Software Engineer
Linux Technology Center - IBM Austin
phone: 512-838-2294
email: sfrench@us.ibm.com

