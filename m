Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932210AbVHKFjf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932210AbVHKFjf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 01:39:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932216AbVHKFjf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 01:39:35 -0400
Received: from web51604.mail.yahoo.com ([206.190.38.209]:18054 "HELO
	web51604.mail.yahoo.com") by vger.kernel.org with SMTP
	id S932210AbVHKFjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 01:39:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=4f4aK3NZFX/JIYKuXog4FiqW96PP/F6/ZMTt5nTX8xCBj2xY/dutcTlACv/oS/DjJG7fl4ndyO6vYY43iyp0AL9sKNIihSi/D/5zCrcXgZJ7SOyRY7UeUdnqUiF9QH5SHlY5gTGyKXSwV/9oBypCBGGX7fuQFPWvLQ/ijkj63K0=  ;
Message-ID: <20050811053931.71120.qmail@web51604.mail.yahoo.com>
Date: Wed, 10 Aug 2005 22:39:31 -0700 (PDT)
From: Ukil a <ukil_a@yahoo.com>
Subject: Need help in understanding  x86  syscall
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had this question. As per my understanding, in the
Linux system call implementation on x86 architecture
the call flows like this int 0x80 -> syscall ->
sys_call_vector(taken from the table)-> return from
interrupt service routine. 

Now I had the doubt that if the the syscall
implementation is very large will the scheduling and
other interrupts be blocked for the whole time till
the process returns from the ISR (because in an ISR by
default the interrupts are disabled unless “sti” is
called explicitly)? That’s appears to be too long for
the scheduling or other interrupts to be blocked? 
Am I missing something here?
    Thanks 
        Ukil

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
