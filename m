Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760491AbWLFLZk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760491AbWLFLZk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 06:25:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760493AbWLFLZk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 06:25:40 -0500
Received: from rwcrmhc12.comcast.net ([204.127.192.82]:48703 "EHLO
	rwcrmhc12.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760488AbWLFLZj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 06:25:39 -0500
Message-ID: <4576A8B3.4090806@comcast.net>
Date: Wed, 06 Dec 2006 06:25:39 -0500
From: Ed Sweetman <safemode2@comcast.net>
User-Agent: Icedove 1.5.0.8 (X11/20061129)
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [PATCH] ata/kconfig: Re: Why SCSI module needed for PCI-IDE ATA
 only disks ?
References: <fa.juE97gahpb4n2kNNH/Todtcvh3s@ifi.uio.no>	<fa.IqtlZas3d+ZPuhF6S6N/ivdF8Wo@ifi.uio.no>	<fa.HDRhmOhDQliejH7ijqJBWw9Jw0o@ifi.uio.no>	<45761B2F.9060804@shaw.ca>	<457625CF.2080105@comcast.net>	<45762781.8020207@shaw.ca>	<45762F1E.4030805@comcast.net> <20061205195427.b5c44f83.randy.dunlap@oracle.com>
In-Reply-To: <20061205195427.b5c44f83.randy.dunlap@oracle.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap wrote:
> On Tue, 05 Dec 2006 21:46:54 -0500 Ed Sweetman wrote:
>
> -ETOOMANYWORDS && -ENOPATCH, so here is one to consider.
> Help text can also be added.  <supply text>
> This is similar to what USB storage already does.
>
>   
I provided a patch a couple weeks ago when I brought this topic up 
myself, but it was largely ignored because it wasn't the "add something 
to help dialog" solution... I figured that the wording would be changed 
anyway by the ide / libata guys or anyone else really involved with the 
kernel.  So I opted to provide a patch that did one of the other 
solutions, namely, adding fake libata block devices in the libata 
section that would merely enable the scsi blk dev variables as if you 
had gone into the scsi section and did it the way it's currently done.  
In any case, prior to this thread, I got basically no response on the 
matter. 

Your patch, however, should at least get into the next kernel revision 
with any additional help text that may be of use. 
Thanks.
