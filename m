Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262845AbVAFOnU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262845AbVAFOnU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 09:43:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262844AbVAFOnU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 09:43:20 -0500
Received: from stat16.steeleye.com ([209.192.50.48]:57268 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262842AbVAFOnO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 09:43:14 -0500
Subject: RE: How to add/drop SCSI drives from within the driver?
From: James Bottomley <James.Bottomley@SteelEye.com>
To: "Mukker, Atul" <Atulm@lsil.com>
Cc: "Bagalkote, Sreenivas" <sreenib@lsil.com>,
       Matt Domsch <Matt_Domsch@Dell.com>,
       "'Salyzyn, Mark'" <mark_salyzyn@adaptec.com>,
       "'brking@us.ibm.com'" <brking@us.ibm.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       "'bunk@fs.tum.de'" <bunk@fs.tum.de>, Andrew Morton <akpm@osdl.org>,
       "Ju, Seokmann" <sju@lsil.com>, "Doelfel, Hardy" <hdoelfel@lsil.com>
In-Reply-To: <0E3FA95632D6D047BA649F95DAB60E57058C01B2@exa-atlanta>
References: <0E3FA95632D6D047BA649F95DAB60E57058C01B2@exa-atlanta>
Content-Type: text/plain
Date: Thu, 06 Jan 2005 09:42:04 -0500
Message-Id: <1105022524.4319.23.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-01-06 at 09:20 -0500, Mukker, Atul wrote:
> For this to happen, the applications must at lease know 'n' in host<n>,
> otherwise it will have to trigger a rescan on all controllers. Which would
> be an overkill. How about publishing the adapter class attribute as well?
> This would allow applications to correlate the adapter handle with the class
> attribute.

I don't see why not ... it's your driver, you can publish whatever extra
information you need as scsi_device attributes; that was one of the
designs of the extensible attribute system.

> Apologize for the late post, we were evaluating your feedback. It looks
> good, thanks!

Great ... so the problem is now solved and just needs to be implemented.

James


