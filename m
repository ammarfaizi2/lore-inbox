Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265230AbUFBXAo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265230AbUFBXAo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 19:00:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265181AbUFBXAo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 19:00:44 -0400
Received: from c7ns3.center7.com ([216.250.142.14]:30434 "EHLO
	smtp.slc03.viawest.net") by vger.kernel.org with ESMTP
	id S265230AbUFBW6q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 18:58:46 -0400
Message-ID: <40BE93DC.6040501@drdos.com>
Date: Wed, 02 Jun 2004 20:58:36 -0600
From: "Jeff V. Merkey" <jmerkey@drdos.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: submit_bh leaves interrupts on upon return
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Any reason why submit_bh should turn on interrupts after being called by 
a process with ints off in 2.4.20?  I see it's possible to sleep during 
elevatoring, but why does it need to leave interrupts on if the calling 
state was with ints off.  

I'm back BTW.  Hope no one missed me.  I can be reached at the email 
address above.

:-)

Jeff



