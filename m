Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262685AbRFLShE>; Tue, 12 Jun 2001 14:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262682AbRFLSgz>; Tue, 12 Jun 2001 14:36:55 -0400
Received: from sncgw.nai.com ([161.69.248.229]:28840 "HELO mcafee-labs.nai.com")
	by vger.kernel.org with SMTP id <S262685AbRFLSgv>;
	Tue, 12 Jun 2001 14:36:51 -0400
Message-ID: <XFMail.20010612113936.davidel@xmailserver.org>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.30.0106121213570.24593-100000@gene.pbi.nrc.ca>
Date: Tue, 12 Jun 2001 11:39:36 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
To: ognen@gene.pbi.nrc.ca
Subject: RE: threading question
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 12-Jun-2001 ognen@gene.pbi.nrc.ca wrote:
> Hello,
> 
> I am a summer student implementing a multi-threaded version of a very
> popular bioinformatics tool. So far it compiles and runs without problems
> (as far as I can tell ;) on Linux 2.2.x, Sun Solaris, SGI IRIX and Compaq
> OSF/1 running on Alpha. I have ran a lot of timing tests compared to the
> sequential version of the tool on all of these machines (most of them are
> dual-CPU, although I am also running tests on 12-CPU Solaris and 108 CPU
> SGI IRIX). On dual-CPU machines the speedups are as follows: my version
> is 1.88 faster than the sequential one on IRIX, 1.81 times on Solaris,
> 1.8 times on OSF/1, 1.43 times on Linux 2.2.x and 1.52 times on Linux 2.4
> kernel. Why are the numbers on Linux machines so much lower? It is the
> same multi-threaded code, I am not using any tricks, the code basically
> uses PTHREAD_CREATE_DETACHED and PTHREAD_SCOPE_SYSTEM and the thread stack
> size is set to 8K (but the numbers are the same with larger/smaller stack
> sizes).
> 
> Is there anything I am missing? Is this to be expected due to Linux way of
> handling threads (clone call)? I am just trying to explain the numbers and
> nothing else comes to mind....

How is your  vmstat  while your tool is running ?



- Davide

