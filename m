Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313761AbSDPQbZ>; Tue, 16 Apr 2002 12:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313760AbSDPQbY>; Tue, 16 Apr 2002 12:31:24 -0400
Received: from webmail10.rediffmail.com ([202.54.124.179]:50833 "HELO
	webmail10.rediffmail.com") by vger.kernel.org with SMTP
	id <S313761AbSDPQbX>; Tue, 16 Apr 2002 12:31:23 -0400
Date: 16 Apr 2002 16:26:04 -0000
Message-ID: <20020416162604.17332.qmail@webmail10.rediffmail.com>
MIME-Version: 1.0
From: "Ajit Anand Shrivastav" <ajeetshree@rediffmail.com>
Reply-To: "Ajit Anand Shrivastav" <ajeetshree@rediffmail.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: prob with SMP
Content-type: text/plain;
	format=flowed
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,
  I have an application level code which has all the logic b...
  within it for the device driver and I have got a kernel le...
  which provides interface to the application for the device.

  Too many errors encountered; the rest of the message is 
ignored:
  The above code works perfectly for Uni-Processor system.
  To make it SMP compliant I have made changes in the driver 
code
  only.Critical section code has been given protection using 
spin
  locks.When I run the application it works for some time which 
is
  not fixed and then the application stops but the system 
remains
  stable.So what does it mean , whether I will have to provide
  synchronization for application level code also to make the
  complete driver SMP compliant.
  If yes, then how to go about synchronizing application level
  code.If no, then what is the problem that is making the
  application halt in between.

  Can anybody help me in this concern ??

  Thanx & regds
  Ajit


