Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264172AbTDPAbk (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 20:31:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264173AbTDPAbk 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 20:31:40 -0400
Received: from boyes.its.utas.edu.au ([144.6.1.7]:25070 "EHLO
	boyes.its.utas.edu.au") by vger.kernel.org with ESMTP
	id S264172AbTDPAbk (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 15 Apr 2003 20:31:40 -0400
Date: Wed, 16 Apr 2003 10:43:27 +1000
Mime-Version: 1.0 (Apple Message framework v551)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Oops in /proc/
From: Thomas Henry Sutton <thsutton@utas.edu.au>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <704602D7-6FA4-11D7-88CB-0003936C3798@utas.edu.au>
X-Mailer: Apple Mail (2.551)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get an Oops (Cannot dereference NULL kernel pointer) for the ls 
process in the following series of  commands:
cd /proc/
cat stat
ls

I am running vanilla 2.5.67 on a Duron without ksyms, so I'll need to 
recompile before I send a ksymoops, but the stack trace looked like it 
was coming from some filesystem functions. Has this already been fixed 
or will I need to send a ksymoops report?

Regards
Thomas Sutton

