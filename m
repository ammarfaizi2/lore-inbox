Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268184AbTBNFsc>; Fri, 14 Feb 2003 00:48:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268188AbTBNFsc>; Fri, 14 Feb 2003 00:48:32 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:58895 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S268184AbTBNFsb>; Fri, 14 Feb 2003 00:48:31 -0500
Date: Fri, 14 Feb 2003 05:58:22 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Sahara Workshop <workshop@cpt.saharapc.co.za>
Cc: KML <linux-kernel@vger.kernel.org>
Subject: Re: Problems with 2.5.*'s SCSI headers and cdrtools
Message-ID: <20030214055822.A18415@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Sahara Workshop <workshop@cpt.saharapc.co.za>,
	KML <linux-kernel@vger.kernel.org>
References: <1045201685.5971.78.camel@workshop.saharact.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1045201685.5971.78.camel@workshop.saharact.lan>; from workshop@cpt.saharapc.co.za on Fri, Feb 14, 2003 at 07:48:06AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2003 at 07:48:06AM +0200, Sahara Workshop wrote:
> 
> Kernel 2.5.5x (have not tried earlier) and 2.5.60 's scsi/scsi.h do
> not have like in 2.4 the 'include <features.h>', or as it may seem
> to need an 'include <types.h>', and thus cdrtools for one do not
> compile.
> 
> The take I get on this from Jorg is that he feels its a problem
> kernel side.  Comments ?

The problem is in cdrtools.  It should not include kernel headers.

> This email and any files transmitted with it are confidential and
> intended solely for the use of the individual or entity to whom they
> are addressed. If you have received this email in error please notify
> the system manager. Please note that any views or opinions presented
> in this email are solely those of the author and do not necessarily
> represent those of Sahara Distribution (Pty) Ltd. Finally, while Sahara
> Distribution attempts to ensure that all email is virus-free, Sahara
> Distribution accepts no liability for any damage caused by any virus
> transmitted by this email.

Blah.  You sent this mail to a public list so this statement is void.

