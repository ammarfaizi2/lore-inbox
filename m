Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282914AbRK0Ki1>; Tue, 27 Nov 2001 05:38:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282913AbRK0KiU>; Tue, 27 Nov 2001 05:38:20 -0500
Received: from [212.169.100.200] ([212.169.100.200]:61172 "EHLO
	sexything.nextframe.net") by vger.kernel.org with ESMTP
	id <S282834AbRK0KiJ>; Tue, 27 Nov 2001 05:38:09 -0500
Date: Tue, 27 Nov 2001 11:44:25 +0100
From: Morten Helgesen <admin@nextframe.net>
To: linux-kernel@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk
Subject: #include <linux/malloc.h> to #include <linux/slab.h> in the 2.2 tree.
Message-ID: <20011127114425.A119@sexything>
Reply-To: admin@nextframe.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-Editor: VIM - Vi IMproved 6.0
X-Keyboard: PFU Happy Hacking Keyboard
X-Operating-System: Slackware Linux (of course)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey there, Alan and the rest of you.

I was just wondering whether or not it would be a waste of time creating a patch with one goal in mind: substituting 
references to linux/malloc.h with references to linux/slab.h throughout the 2.2 tree. 

Inconsistency is a Bad Thing[tm], and since malloc.h now only includes slab.h, I feel that it is time for a major clean-up.
Any thoughts ?


== Morten

-- 
mvh
Morten Helgesen 
UNIX System Administrator & C Developer 
Nextframe AS, Horten, Norway
admin@nextframe.net / 93445641
http://www.nextframe.net
