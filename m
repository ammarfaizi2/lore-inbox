Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261416AbULIBLY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261416AbULIBLY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 20:11:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261419AbULIBLY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 20:11:24 -0500
Received: from stat16.steeleye.com ([209.192.50.48]:58777 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261416AbULIBLV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 20:11:21 -0500
Subject: RE: How to add/drop SCSI drives from within the driver?
From: James Bottomley <James.Bottomley@SteelEye.com>
To: "Bagalkote, Sreenivas" <sreenib@lsil.com>
Cc: Matt Domsch <Matt_Domsch@Dell.com>,
       "'brking@us.ibm.com'" <brking@us.ibm.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       "'bunk@fs.tum.de'" <bunk@fs.tum.de>, "'Andrew Morton'" <akpm@osdl.org>,
       "Ju, Seokmann" <sju@lsil.com>, "Doelfel, Hardy" <hdoelfel@lsil.com>,
       "Mukker, Atul" <Atulm@lsil.com>
In-Reply-To: <0E3FA95632D6D047BA649F95DAB60E570230CA8F@exa-atlanta>
References: <0E3FA95632D6D047BA649F95DAB60E570230CA8F@exa-atlanta>
Content-Type: text/plain
Date: Wed, 08 Dec 2004 13:06:34 -0600
Message-Id: <1102532794.4013.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-12-08 at 12:56 -0500, Bagalkote, Sreenivas wrote:
> >The real way I'd like to handle this is via hotplug.  The 
> >hotplug event would transmit the HCTL in the environment.  
> >Whether the drive actually gets incorporated into the system 
> >and where is user policy, so it's appropriate that it should 
> >be in userland.
> 
> James, it is the application that is adding the drive. So it is not a
> hotplug
> event for the driver.

Then perhaps I don't understand what the issue is.  If the application
is adding the drive, then surely it would know the numbers.  If not,
then the driver must communicate this back, and that's what the hotplug
would be about.

James


