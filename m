Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263930AbRF0QXd>; Wed, 27 Jun 2001 12:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263963AbRF0QXX>; Wed, 27 Jun 2001 12:23:23 -0400
Received: from amadeus.resilience.com ([209.245.157.29]:42837 "HELO jmcmullan")
	by vger.kernel.org with SMTP id <S263930AbRF0QXI>;
	Wed, 27 Jun 2001 12:23:08 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Jason McMullan <jmcmullan@linuxcare.com>
Newsgroups: local.linux.kernel
Subject: Re: multi-path IO in SCSI mid-layer
Date: 27 Jun 2001 16:07:22 GMT
Organization: Matrix Fire Systems
Distribution: local
Message-ID: <9hd0bq$unp$1@localhost.localdomain>
In-Reply-To: <20010626110040.A28555@eng2.sequent.com>
NNTP-Posting-Host: localhost.localdomain
X-Trace: localhost.localdomain 993658042 31481 127.0.0.1 (27 Jun 2001 16:07:22 GMT)
X-Complaints-To: news@localhost
NNTP-Posting-Date: 27 Jun 2001 16:07:22 GMT
Cc: patman@sequent.com
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.5 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mansfield <patman@sequent.com> wrote:
> I'm interested in multi-path IO in the linux scsi mid-layer.
>
> Are there developers working on changes to the scsi layers/interfaces?
> I've seen references about such work, but no details.
>
> [snip snip]
>
> But, a decent multi-path IO implementation requires significant changes
> to the current linux scsi interfaces/structures - especially where no
> functional interfaces exist, such as the direct references to Scsi_Device
> host, and Scsi_Host host_queue.

	At Linuxcare I have written a multi-path system for Linux 2.2.x
to support Sun's T3 hardware. It's pretty generic, though. (A user
in Europe has reported success with the IBM Shark SAN with our 
SCSI Alias Chains failover system).

	For source code, please see:

	http://open-projects.linuxcare.com/t3/

	Please contact me by email if you're interested in a version for 2.4.x.

-- 
Jason McMullan, Senior Linux Consultant
Linuxcare, Inc. 412.432.6457 tel, 412.656.3519 cell
jmcmullan@linuxcare.com, http://www.linuxcare.com/
Linuxcare. Putting open source to work.
