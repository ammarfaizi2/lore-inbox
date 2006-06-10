Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932597AbWFJAKM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932597AbWFJAKM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 20:10:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932601AbWFJAKM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 20:10:12 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:19172 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932597AbWFJAKL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 20:10:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=KJ+6InCg0LPd51ReE0Ymy5J+auvkA05H5v2Wj3zxyU0LeiLFLG+GdOMqE+XBecwesGOQ8mbmML2m6Vjtxfm3ax4XLXPnUu1+TwkA66tcbsZrv1szXRfUwEhuBa0W9BPSCk+eGKMyg3NLcZjcdwfq3ylBl7KCHuSvn57Rxjym4q0=
Message-ID: <4ae3c140606091710k7a320f2ex6390d0e01da4de9b@mail.gmail.com>
Date: Fri, 9 Jun 2006 20:10:10 -0400
From: "Xin Zhao" <uszhaoxin@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: How long can an inode structure reside in the inode_cache?
Cc: linux-fsdevel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was wondering how Linux decide to free an inode from the
inode_cache? If a file is open, an inode structure will be created and
put into the inode_cache, but when will this inode be free and removed
from the inode_cache? after this file is closed? If so, this seems to
be inefficient.

Can someone tell me how Linux handle this issue?

Thanks,
Xin
