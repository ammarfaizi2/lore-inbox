Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751973AbWJaFaj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751973AbWJaFaj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 00:30:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751577AbWJaFaj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 00:30:39 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:49949 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751476AbWJaFai (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 00:30:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=W9nCqHr5R/iuA6jdzfKxmqH5gAXP4pntXXnRU8SBRr70+Y4DMsD/qSNIcGrq1UHt92a/pX9Q0x03Gcfe3XUgVmg6nxeGHqCpSuaSdGW8z69HyW9jZTRnAEc8+TfLyzUqPyytXM6uMIHo5+Ty1gxXjL0VioHV0nf1hZa0tfR+i0E=
Message-ID: <6d6a94c50610302130u55fc3f59n7be157a73c50805e@mail.gmail.com>
Date: Tue, 31 Oct 2006 13:30:36 +0800
From: Aubrey <aubreylee@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: How to add a device file to sysfs?
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

When a misc device file is registered, there are two files under my
own class directory:

/sys --> class --> misc --> myprog --> dev
                                                   --> uevent
                                                   --> myprog_show (to be added)

Now, my question is, is it possbile to add the third file
"myprog_show" under "myprog" directory without modify any common code?

I've read the doc under linux-2.6.x/Documentation, I can add it to
some other directory, but not found a way to add it to my own
directory.

Thanks for any help.
-Aubrey
