Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291324AbSBSMBT>; Tue, 19 Feb 2002 07:01:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291327AbSBSMBJ>; Tue, 19 Feb 2002 07:01:09 -0500
Received: from ns.ithnet.com ([217.64.64.10]:62216 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S291324AbSBSMA4>;
	Tue, 19 Feb 2002 07:00:56 -0500
Date: Tue, 19 Feb 2002 12:55:47 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: wpeter@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Encountered a Null Pointer Problem on the SCSI Layer
Message-Id: <20020219125547.2aebebba.skraw@ithnet.com>
In-Reply-To: <20020218190407.A16616@devserv.devel.redhat.com>
In-Reply-To: <OFC7A42817.7DD2C3FB-ON85256B64.00725D00@raleigh.ibm.com>
	<200202182301.AAA23425@webserver.ithnet.com>
	<20020218190407.A16616@devserv.devel.redhat.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.7.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Feb 2002 19:04:07 -0500
Pete Zaitcev <zaitcev@redhat.com> wrote:

> > Date: Tue, 19 Feb 2002 00:01:39 +0100
> > From: Stephan von Krawczynski <skraw@ithnet.com>
> 
> > Are you 100% sure, that there is no case where                        
> > dpnt==NULL? Because if there is such a possibility, your patch will   
> > blow up.                                                              
> 
> If there is such a possibility, everything will blow up.

Re-reading the code, you are right. This patch is fine.

Regards,
Stephan


