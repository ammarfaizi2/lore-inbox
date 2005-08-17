Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750834AbVHQEjk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750834AbVHQEjk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 00:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbVHQEjk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 00:39:40 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:49869 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750829AbVHQEjj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 00:39:39 -0400
Date: Tue, 16 Aug 2005 21:39:33 -0700
From: Patrick Mansfield <patmans@us.ibm.com>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       "linux-usb-devel@lists.sourceforge.net" 
	<linux-usb-devel@lists.sourceforge.net>,
       "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: Re: [2.6.13-rc6-latest] SCSI disk registration msgs repeat themselves
Message-ID: <20050817043933.GA2803@us.ibm.com>
References: <200508162304_MC3-1-A768-3F2@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508162304_MC3-1-A768-3F2@compuserve.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2005 at 11:01:30PM -0400, Chuck Ebbert wrote:
>   I just added some usb-storage devices to my system and got the below.
> Why do the first four lines repeat for each device?  (Not sure if
> this is a SCSI or USB problem.)

It is in the partition code. I posted twice before about this with no
response.

The changelog said it was a workaround for a borken device, but not what
device it was or any other details.

There is a patch (against 2.6.11) in the below, I haven't tried it with
recent kernels:

http://marc.theaimsgroup.com/?l=linux-scsi&m=110719123625593&w=2
http://marc.theaimsgroup.com/?l=linux-scsi&m=110848617107098&w=2

-- Patrick Mansfield
