Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269522AbTCDTuR>; Tue, 4 Mar 2003 14:50:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269524AbTCDTuR>; Tue, 4 Mar 2003 14:50:17 -0500
Received: from mta03-svc.ntlworld.com ([62.253.162.43]:36531 "EHLO
	mta03-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S269522AbTCDTuR> convert rfc822-to-8bit; Tue, 4 Mar 2003 14:50:17 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: no_spam@ntlworld.com
To: linux-kernel@vger.kernel.org
Subject: kill_fasync usage
Date: Tue, 4 Mar 2003 20:08:16 +0000
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200303042008.16839.no_spam@ntlworld.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dear list, 

quick advice please,

I wnat to use kill_fasync(struct fasync_struct *PTR,...) to notify userland of 
events.  Can I just call kill_fasync regardless of the state of PTR or does 
PTR actually have to point to something valid.  

In my code PTR=NULL initially and may or may not be set or unset during use. I 
would like to know if I can call kill_fasync without testing what is in PTR.  
If I have to test what would PTR be if there isn't anything in the queue?
If I can't test PTR how can I find out from the arguments to my fasync method 
if I am adding (or removing) processes from the list?

Thanks SA 
