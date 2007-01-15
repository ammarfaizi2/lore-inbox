Return-Path: <linux-kernel-owner+w=401wt.eu-S932078AbXAOXZM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078AbXAOXZM (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 18:25:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932099AbXAOXZM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 18:25:12 -0500
Received: from smtp161.iad.emailsrvr.com ([207.97.245.161]:50212 "EHLO
	smtp161.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932078AbXAOXZK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 18:25:10 -0500
Message-ID: <45AC0DB0.5020000@gentoo.org>
Date: Mon, 15 Jan 2007 18:26:40 -0500
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Thunderbird 2.0b1 (X11/20061221)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Trond.Myklebust@netapp.com
Subject: Some kind of 2.6.19 NFS regression
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Tim Ryan has reported the following bug at the Gentoo bugzilla:

https://bugs.gentoo.org/show_bug.cgi?id=162199

His home dir is mounted over NFS. 2.6.18 worked OK but 2.6.19 is very 
slow to load the desktop environment. NFS is suspected here as the 
problem does not exist for users with local homedirs. This might not be 
a straightforward performance issue as it does seem to perform OK on the 
console.

The bug still exists in unpatched 2.6.20-rc5.

Is this a known issue? Should we report a new bug on the kernel bugzilla?

Thanks,
Daniel
