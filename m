Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263245AbUJ2AiI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263245AbUJ2AiI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 20:38:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263254AbUJ2Ah5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 20:37:57 -0400
Received: from web51805.mail.yahoo.com ([206.190.38.236]:13998 "HELO
	web51805.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263245AbUJ2AZK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 20:25:10 -0400
Message-ID: <20041029002502.80901.qmail@web51805.mail.yahoo.com>
Date: Thu, 28 Oct 2004 17:25:02 -0700 (PDT)
From: Phy Prabab <phyprabab@yahoo.com>
Subject: md and multipathing
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone!

I have a question concerning md driver: is there a way
to have a multipath md that is mulitplexed?  That is I
have seen that when I create a multipath device, the
device only uses on channel, always seems to be the
first channel I use in the command line, to drive path
even if I do not specify the second channel as a spare
device?

I am using mdadm with 2.6.9 kernel.

mdadm --create --force -lmp -n2 /dev/md0 /dev/sda
/dev/sdc

iostat always shows data flowing across only one
channel as if the second device is in passive mode
waiting for failover.

Thank you for your time.

Phy


		
__________________________________
Do you Yahoo!?
Yahoo! Mail Address AutoComplete - You start. We finish.
http://promotions.yahoo.com/new_mail 
