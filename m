Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263063AbVFXPgy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263063AbVFXPgy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 11:36:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263035AbVFXPdp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 11:33:45 -0400
Received: from electron.sophos.com ([213.86.172.148]:3242 "EHLO
	electron.sophos.com") by vger.kernel.org with ESMTP id S263023AbVFXPci
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 11:32:38 -0400
MIME-Version: 1.0
X-MIMETrack: S/MIME Sign by Notes Client on Tvrtko Ursulin/Dev/UK/Sophos(Release 5.0.12
  |February 13, 2003) at 24/06/2005 16:32:29,
	Serialize by Notes Client on Tvrtko Ursulin/Dev/UK/Sophos(Release 5.0.12  |February
 13, 2003) at 24/06/2005 16:32:29,
	Serialize complete at 24/06/2005 16:32:29,
	S/MIME Sign failed at 24/06/2005 16:32:29: The cryptographic key was not
 found,
	S/MIME Sign by Notes Client on Tvrtko Ursulin/Dev/UK/Sophos(Release 5.0.12
  |February 13, 2003) at 24/06/2005 16:32:34,
	Serialize by Notes Client on Tvrtko Ursulin/Dev/UK/Sophos(Release 5.0.12  |February
 13, 2003) at 24/06/2005 16:32:34,
	Serialize complete at 24/06/2005 16:32:34,
	S/MIME Sign failed at 24/06/2005 16:32:34: The cryptographic key was not
 found,
	Serialize by Router on Mercury/Servers/Sophos(Release 6.5.2|June 01, 2004) at
 24/06/2005 16:32:37,
	Serialize complete at 24/06/2005 16:32:37
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] ndevfs - a "nano" devfs
X-Mailer: Lotus Notes Release 5.0.12   February 13, 2003
Message-ID: <OFD982C671.CCDA87F9-ON8025702A.0054FDEB-8025702A.00556118@sophos.com>
From: tvrtko.ursulin@sophos.com
Date: Fri, 24 Jun 2005 16:32:34 +0100
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/06/2005 16:23:11 Greg KH wrote:

>> ndevfs: creating file '0000:02' with major 0 and minor 0
>
>Hm, that is odd.  That shouldn't happen.
>
>Wait, I think it was due to where you put the class hooks, try it
>against Linus's latest tree, it will work better there (in fact, I don't
>know if it would work properly in 2.6.12 due to the class driver core
>changes.)
>
>Could you try that and let me know if it still has issues?

It was me incorrectly fixing the rejects. If I had looked at it more 
carefully I would have got it right the first time. Anyway, I moved the 
relevant ndevfs_create in the right 'if' block and now everything is fine. 
Am I still using 2.6.12 btw.

Sorry for not letting you know that earlier, I was waiting for my post to 
show up so that I can reply to myself.


