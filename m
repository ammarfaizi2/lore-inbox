Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262373AbULCRb4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262373AbULCRb4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 12:31:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262431AbULCRbz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 12:31:55 -0500
Received: from mail0.lsil.com ([147.145.40.20]:24766 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S262399AbULCR0T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 12:26:19 -0500
Message-ID: <0E3FA95632D6D047BA649F95DAB60E570230CA72@exa-atlanta>
From: "Bagalkote, Sreenivas" <sreenib@lsil.com>
To: "'Matt Domsch'" <Matt_Domsch@dell.com>,
       "Bagalkote, Sreenivas" <sreenib@lsil.com>
Cc: "'brking@us.ibm.com'" <brking@us.ibm.com>,
       "'James Bottomley'" <James.Bottomley@SteelEye.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
       "'bunk@fs.tum.de'" <bunk@fs.tum.de>, "'Andrew Morton'" <akpm@osdl.org>,
       "Ju, Seokmann" <sju@lsil.com>, "Doelfel, Hardy" <hdoelfel@lsil.com>,
       "Mukker, Atul" <Atulm@lsil.com>
Subject: RE: How to add/drop SCSI drives from within the driver?
Date: Fri, 3 Dec 2004 12:18:22 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

4 Against        0 For

That settles it. Thank you all for your replies.

Sreenivas
LSI Logic 

>-----Original Message-----
>From: Matt Domsch [mailto:Matt_Domsch@dell.com] 
>Sent: Friday, December 03, 2004 12:14 PM
>To: Bagalkote, Sreenivas
>Cc: 'brking@us.ibm.com'; 'James Bottomley'; 
>'linux-kernel@vger.kernel.org'; 'linux-scsi@vger.kernel.org'; 
>'bunk@fs.tum.de'; 'Andrew Morton'; Ju, Seokmann; Doelfel, 
>Hardy; Mukker, Atul
>Subject: Re: How to add/drop SCSI drives from within the driver?
>
>On Fri, Dec 03, 2004 at 11:11:01AM -0600, Matt Domsch wrote:
>> Doing it within the driver means you've got to release a new driver 
>> for each affected OS, to avoid having to update the userspace app on 
>> each OS.  I claim it's much easier to update a userspace 
>lib/app than 
>> it is to update a driver on each installed system.
>
>And, you're going to have to update the userspace lib/app to 
>add the new ioctl()-invocation to it anyhow.  So take the hit 
>*only* there and make it use either /sys or /proc, whichever 
>is available, no kernel changes.  Yes?
>
>--
>Matt Domsch
>Sr. Software Engineer, Lead Engineer
>Dell Linux Solutions linux.dell.com & www.dell.com/linux Linux 
>on Dell mailing lists @ http://lists.us.dell.com
>
