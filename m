Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131634AbRCOFPh>; Thu, 15 Mar 2001 00:15:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131649AbRCOFP1>; Thu, 15 Mar 2001 00:15:27 -0500
Received: from lacrosse.corp.redhat.com ([207.175.42.154]:38370 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S131594AbRCOFPM>; Thu, 15 Mar 2001 00:15:12 -0500
Message-ID: <3AB050D3.15AF5EF1@redhat.com>
Date: Thu, 15 Mar 2001 00:19:15 -0500
From: Doug Ledford <dledford@redhat.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Bob Frey <bfrey@turbolinux.com.cn>
CC: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: scsi_scan problem.
In-Reply-To: <3AB028BE.E8940EE6@redhat.com> <20010314213543.A30816@devserv.devel.redhat.com> <20010315130641.A14138@bfrey.dev.cn.tlan>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bob Frey wrote:
> 
> On Wed, Mar 14, 2001 at 09:35:43PM -0500, Pete Zaitcev wrote:
> > 16384 LUNs for Fibre Channel. As you see, scanning is out of the
> > question. You must issue REPORT LUNs and fall back on scanning
> > if the device reports a check condition. I did that when I worked
> Why wait for a check condition? There's an INQUIRY field bit that
> indicates whether REPORT LUNs is supported.

And I'm all for using it in the 2.5 kernel SCSI stack ;-)

-- 

 Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
      Please check my web site for aic7xxx updates/answers before
                      e-mailing me about problems
