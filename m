Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269043AbUIMWxD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269043AbUIMWxD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 18:53:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269050AbUIMWwo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 18:52:44 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:21234 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S269043AbUIMWvm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 18:51:42 -0400
Subject: Re: 2.6.9-rc1-mm5 qlogic oops
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andrew Vasquez <andrew.vasquez@qlogic.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
In-Reply-To: <20040913212413.GA22149@praka.san.rr.com>
References: <1095100546.3628.162.camel@dyn318077bld.beaverton.ibm.com>
	 <20040913212413.GA22149@praka.san.rr.com>
Content-Type: text/plain
Organization: 
Message-Id: <1095115675.3628.175.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 13 Sep 2004 15:47:56 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It worked. 

Thanks,
Badari

On Mon, 2004-09-13 at 14:24, Andrew Vasquez wrote:
> On Mon, 13 Sep 2004, Badari Pulavarty wrote:
> 
> > 
> > I get this Oops with qlogic 2200 FC controllers with 2.6.9-rc1-mm5.
> > Is this a known issue ? Any fixes ?
> > 
> 
> Hmm, there seems to be some merging problems in changeset 1.44 for
> qla_os.c -- the 'DMA pool/api usage' patch I sent is not completely
> integrated (appears to be massaging problems while attempting to apply
> on top off 1.43).
> 
> Please apply the attached patch which should address the issue.
> 
> Regards,
> Andrew Vasquez

