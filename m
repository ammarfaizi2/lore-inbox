Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269769AbUJGJcL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269769AbUJGJcL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 05:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269766AbUJGJbm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 05:31:42 -0400
Received: from mailhub2.uq.edu.au ([130.102.149.128]:263 "EHLO
	mailhub2.uq.edu.au") by vger.kernel.org with ESMTP id S269769AbUJGJbD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 05:31:03 -0400
Message-ID: <41650CAF.1040901@unimail.com.au>
Date: Thu, 07 Oct 2004 19:30:23 +1000
From: Fraz <fraz@unimail.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: High pitched noise from laptop: processor.c in linux 2.6
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently upgraded from linux 2.4.27 to 2.6.8.1 and noticed my laptop 
now makes a high pitch noise while idle. I traced it back to the 
processor module for acpi. 'rmmod processor' stops the noise. 

 

Using speed step to turn it down to 733 Mhz makes it a 
        little quieter and doesn't change the tone. 

 

Is there any way to stop this? I googled around and found it had 
something to do with idle frequency of 1000 Hz in 2.6 instead of 100Hz 
in the 2.4 kernel. I couldn't find much else on this. Hunting around the 
code didn't help much, I don't know C. 

 

The laptop is a Compaq Evo N160 from Dec 2001. The reference in google 
was to a Centrino laptop with the same problem. I wrote to Dominik 
Brodowski who suggested posting here.


fraz
