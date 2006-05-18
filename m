Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751026AbWERLpN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751026AbWERLpN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 07:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751153AbWERLpN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 07:45:13 -0400
Received: from smtp3.clb.oleane.net ([213.56.31.19]:50643 "EHLO
	smtp3.clb.oleane.net") by vger.kernel.org with ESMTP
	id S1751026AbWERLpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 07:45:12 -0400
Message-ID: <446C5E25.1060007@gmail.com>
Date: Thu, 18 May 2006 13:44:37 +0200
From: "sej.kernel" <sej.kernel@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: sshd limits
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I modified
1) /etc/security/limits.conf :
* hard memlock 256000
* soft memlock 256000

2) /etc/pam.d/login and /etc/pam.d/sshd
session required pam_limits.so

Then I restarted sshd (service sshd restart) to applay changes.

But when I connect to my PC via ssh I don't have the good memlock rlimit.
Then if I use 'su mylogin', I have the right limits !!
So what did I forget in my configuration ?
 
regards,
sej

