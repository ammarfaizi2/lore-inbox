Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266488AbUJAUv0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266488AbUJAUv0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 16:51:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266485AbUJAUsj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 16:48:39 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:34974 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S266517AbUJAUoD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 16:44:03 -0400
Subject: RE: [PATCH]: megaraid 2.20.4: Fixes a data corruption bug
From: James Bottomley <James.Bottomley@SteelEye.com>
To: "Bagalkote, Sreenivas" <sreenib@lsil.com>
Cc: "Mukker, Atul" <Atulm@lsil.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
       "'bunk@fs.tum.de'" <bunk@fs.tum.de>, "'Andrew Morton'" <akpm@osdl.org>,
       "'Matt_Domsch@dell.com'" <Matt_Domsch@dell.com>,
       "Ju, Seokmann" <sju@lsil.com>
In-Reply-To: <0E3FA95632D6D047BA649F95DAB60E570230C986@exa-atlanta>
References: <0E3FA95632D6D047BA649F95DAB60E570230C986@exa-atlanta>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 01 Oct 2004 16:43:52 -0400
Message-Id: <1096663438.1766.97.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-01 at 16:32, Bagalkote, Sreenivas wrote:
> Without CONFIG_COMPAT around them, I get "unresolved symbol"
> for (un)register_ioctl32_conversion while loading the module.

Not in the latest -bk or -mm kernels if you check.  The primitives to
allow this were added to include/linux/ioctl32.h

James


