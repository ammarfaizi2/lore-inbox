Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759691AbWLFCPn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759691AbWLFCPn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 21:15:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759675AbWLFCPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 21:15:43 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:11031 "EHLO
	pd4mo1so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759691AbWLFCPm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 21:15:42 -0500
Date: Tue, 05 Dec 2006 20:14:25 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Why SCSI module needed for PCI-IDE ATA only disks ?
In-reply-to: <457625CF.2080105@comcast.net>
To: Ed Sweetman <safemode2@comcast.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <45762781.8020207@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <fa.juE97gahpb4n2kNNH/Todtcvh3s@ifi.uio.no>
 <fa.IqtlZas3d+ZPuhF6S6N/ivdF8Wo@ifi.uio.no>
 <fa.HDRhmOhDQliejH7ijqJBWw9Jw0o@ifi.uio.no> <45761B2F.9060804@shaw.ca>
 <457625CF.2080105@comcast.net>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed Sweetman wrote:
> What's not a legitimate configuration is libata drivers, no low level 
> scsi drivers, no ide drivers and no sd,sr,sg drivers.  Yet, that is the 
> configuration the kernel currently gives you. How is that more correct 
> than any of the 3 solutions I have suggested?

You can't build libata without low-level SCSI drivers. CONFIG_ATA 
automatically selects CONFIG_SCSI.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/


