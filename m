Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030311AbWFOMWL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030311AbWFOMWL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 08:22:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030318AbWFOMWL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 08:22:11 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:33994 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1030311AbWFOMWK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 08:22:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=gnjMq1hvjlmcHGRcKT0sq1ynJ9sfgKK6kwGdeaJNs3ND0lOuCHs790zEhwGMnuHsALb3GKH5F4Its2rqywmUqjCXX8dqrDynTZF/JysYrj20XKMrYO+MVjTSohAQxFOfEqVd1juG5c27I0lbeidzD/VHgxNB+d5jf0LtAItfvVw=
Message-ID: <8bf247760606150522w6e66bbcfs8951dff00db8277a@mail.gmail.com>
Date: Thu, 15 Jun 2006 17:52:09 +0530
From: Ram <vshrirama@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Network drivers - porting to 2.6 issues
Cc: linux-arm-kernel@lists.arm.linux.org.uk
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  I have  ported a wlan driver from 2.4 to 2.6.

  I am referring to the porting article in lwn.net.


  The driver works fine for sometime. after which data transfer
becomes very slow.


  i have telnet to a remote machine. i do ls -Rl /

  data transfer is ok to start with, then it becomes very slow.

  also whatever i type on the shell prompt appears after a while.

  This happens - sometimes it is faster and then slow. this goes on in a cycle.


  Is there any difference between a 2.4 and 2.6 kernel network stack?.


  I have changed registeration, changing task queues to work queues
and stuff like that.


   am not sure if the network stack api's and thier meanings have changed.

   is there anything i should watch out for?.


  sometimes i do get : NETDEV WATCHDOG: eth1: transmit timed out


   What does this mean?.


 is there anything more i should watch out for?.

Regards,
sriram
