Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264071AbRFKKja>; Mon, 11 Jun 2001 06:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264074AbRFKKjV>; Mon, 11 Jun 2001 06:39:21 -0400
Received: from [195.57.250.2] ([195.57.250.2]:13196 "EHLO mcolom.barcelo")
	by vger.kernel.org with ESMTP id <S264071AbRFKKjE>;
	Mon, 11 Jun 2001 06:39:04 -0400
Message-ID: <3B249DDA.E9D69933@barcelo.com>
Date: Mon, 11 Jun 2001 12:30:50 +0200
From: Miquel Colom Piza <m.colom@barcelo.com>
X-Mailer: Mozilla 4.72 [es] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Calculation of private memory of processes for estimation of RAM  in big 
 server
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I would like to know how to calculate the amount of private memory (i.e.
memory used only by that process) so I can estimate the total amount of
RAM I have to put in a heavy loaded server.

In Sun Solaris I use a tool called pmap that gives me a resume of the
private and shared memory and the size image of each process. This pmap
utility uses the /proc filesystem to obtain the information.

In Linux I've used ps axl and I think that the RSS column is the right
one, but I'm not sure. Also I've look at the file
/proc/<PID_OF_PROCESS>/status that has, for example,  these lines:

VmSize:     1144 kB
VmLck:         0 kB
VmRSS:        52 kB
VmData:       28 kB
VmStk:         8 kB
VmExe:        56 kB
VmLib:      1024 kB

But again I'm not sure which one of these numbers is the one to look at.
Could please
any VM guru help with this?

Please CC me because I'm not subscribed to the list

Best regards

Miquel Colom

