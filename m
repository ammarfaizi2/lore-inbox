Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261222AbUKHUwd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261222AbUKHUwd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 15:52:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261221AbUKHUvW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 15:51:22 -0500
Received: from webmail-outgoing.us4.outblaze.com ([205.158.62.67]:41868 "EHLO
	webmail-outgoing.us4.outblaze.com") by vger.kernel.org with ESMTP
	id S261217AbUKHUuy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 15:50:54 -0500
X-OB-Received: from unknown (205.158.62.49)
  by wfilter.us4.outblaze.com; 8 Nov 2004 20:50:40 -0000
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "dan carpenter" <error27@email.com>
To: "Andreas Dilger" <adilger@clusterfs.com>
Cc: linux-kernel@vger.kernel.org
Date: Mon, 08 Nov 2004 15:50:39 -0500
Subject: Re: ext2/3 issue 2.6 vs 2.4 kernels
X-Originating-Ip: 67.112.215.16
X-Originating-Server: ws1-1.us4.outblaze.com
Message-Id: <20041108205039.CFE634BE64@ws1-1.us4.outblaze.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Do you use EAs and SELinux security extensions under 2.6?  This can
> make symlinks appear to be "slow" symlinks because of the added EA
> block, and that will cause them to point into nothingness under 2.4.
> 
> Cheers, Andreas

Yes.  You are correct.  That's what's happenning.

https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=137068

John Reiser sent me the bugzilla link in an email.

regards,
dan carpenter


-- 
___________________________________________________________
Sign-up for Ads Free at Mail.com
http://promo.mail.com/adsfreejump.htm

