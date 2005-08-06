Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261996AbVHFHIK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261996AbVHFHIK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 03:08:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262020AbVHFHIK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 03:08:10 -0400
Received: from wproxy.gmail.com ([64.233.184.205]:38295 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261996AbVHFHII convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 03:08:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=XRVnPLnRiZUcvzP1fdL6P9uanUfTuoAD1cDv5oHrb7/TJtbMHw8WinPqkMxR2P9Y9UGusTdFmgY9ddy6ReVwjx6tWo5FL277OgiUZb8R6Ec5RnSvOcAgYvFfQhkFRdHs0q8zIrCLSxVRQYOAxwdngbTIBOVMmcUG0sHNRETc+eU=
Message-ID: <4ae3c1405080600082ef440c8@mail.gmail.com>
Date: Sat, 6 Aug 2005 03:08:05 -0400
From: Xin Zhao <uszhaoxin@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Any access control mechanism that allow exceptions?
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I want to lock down a directory to be read-only, say, /etc, for system
security. Unfortunately, some valid system tools might need to
create/modified files like "/etc/dhclient-eth0.conf".  To avoid
disrupting the normal running of those tools, I might have to allow
certain files to be created under /etc.

Is there any way that allows me to specify what files are allowed to
be created while locking down the whole directory at most of the time?

I think of adding an exception list as extend attributes of Ext3
filesystem, and changes the Ext3 filesystem to enforce the policy. But
this method looks awful.

Any elegant way to achieve this goal? 

Thanks

xin
