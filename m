Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965053AbVLVGgr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965053AbVLVGgr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 01:36:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965054AbVLVGgr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 01:36:47 -0500
Received: from xproxy.gmail.com ([66.249.82.195]:24244 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965053AbVLVGgr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 01:36:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=WGshG21QD2UbUO/CG0uZ1H5nt9elfAQrhVwQzFBnZPibIZgf1hHXKHfW+NuW43paoTaezmfw5ZqN4KyN2hbS7LO5+9RCrHrRdTMNNw5PR/XZ91lrF1/FaiM7jb/M2RfxqNkkme3fPd7wF3cJi4VQEKJN1l6dKl0wFkmzA+NsXa8=
Message-ID: <993d182d0512212236u525b6f25wf1dcaae9c389537f@mail.gmail.com>
Date: Thu, 22 Dec 2005 12:06:46 +0530
From: Conio sandiago <coniodiago@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Un aligned addresses
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all
i have a embedded monta vista linux running.
i have developed a ethernet driver.
Its working Ok,
But i am facing some problem with the throughput.

After a lot of observation ,
i observed that i am getting un-aligned addresses of the data payload
from the TCP/IP stack.because of this problem i always have to do
memcpy to a word aligned buffer,because of which throughput is reduced
significantly.

Does anybody has some solution for this.
Regards
conio
