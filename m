Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264571AbUJETXU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264571AbUJETXU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 15:23:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264530AbUJETXU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 15:23:20 -0400
Received: from mail0.lsil.com ([147.145.40.20]:60894 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S261239AbUJETXP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 15:23:15 -0400
Message-ID: <0E3FA95632D6D047BA649F95DAB60E570230C98F@exa-atlanta>
From: "Bagalkote, Sreenivas" <sreenib@lsil.com>
To: "'James Bottomley'" <James.Bottomley@SteelEye.com>
Cc: "Mukker, Atul" <Atulm@lsil.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
       "'bunk@fs.tum.de'" <bunk@fs.tum.de>, "'Andrew Morton'" <akpm@osdl.org>,
       "'Matt_Domsch@dell.com'" <Matt_Domsch@dell.com>,
       "Ju, Seokmann" <sju@lsil.com>
Subject: RE: [PATCH]: megaraid 2.20.4: Fixes a data corruption bug
Date: Tue, 5 Oct 2004 15:15:12 -0400 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James,

The latest megaraid driver on bk://linux-scsi.bkbits.net/scsi-misc-2.6 still
has
CONFIG_COMPAT around register_ioctl32_conversion. Will it remain in the
source
or should it go?

Thanks,
Sreenivas


>-----Original Message-----
>From: James Bottomley [mailto:James.Bottomley@SteelEye.com]
>Sent: Friday, October 01, 2004 7:09 PM
>To: Bagalkote, Sreenivas
>Cc: Mukker, Atul; 'linux-kernel@vger.kernel.org';
>'linux-scsi@vger.kernel.org'; 'bunk@fs.tum.de'; 'Andrew Morton';
>'Matt_Domsch@dell.com'; Ju, Seokmann
>Subject: RE: [PATCH]: megaraid 2.20.4: Fixes a data corruption bug
>
>
>On Fri, 2004-10-01 at 18:52, Bagalkote, Sreenivas wrote:
>> Would you please send us your version of megaraid driver that will
>> most likely go into 2.6.9? We would like baseline your version and
>> make our internal releases off of that. I appreciate your help.
>
>You can get my tree in bitkeeper here
>
>bk://linux-scsi.bkbits.net/scsi-misc-2.6
>
>Or, you can get it (with a slight time lag) in the -mm tree:
>
>http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/
>
>James
>
>
