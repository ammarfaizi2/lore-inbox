Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264035AbUDBMwM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 07:52:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264037AbUDBMwM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 07:52:12 -0500
Received: from mail.cyclades.com ([64.186.161.6]:20168 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S264035AbUDBMwL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 07:52:11 -0500
Date: Fri, 2 Apr 2004 09:36:39 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: "Dupuis, Chad" <chad.dupuis@hp.com>
Cc: James.Bottomley@HansenPartnership.com, linux-kernel@vger.kernel.org
Subject: Re: HSG80 entry in drivers/scsi/scsi_scan.c
Message-ID: <20040402123639.GF1998@logos.cnet>
References: <A8B003DDA3332A479C0ECCA641F47E6503BE66F5@tayexc13.americas.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A8B003DDA3332A479C0ECCA641F47E6503BE66F5@tayexc13.americas.cpqcorp.net>
User-Agent: Mutt/1.5.5.1i
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2004 at 04:40:00PM -0500, Dupuis, Chad wrote:
> Hello,
> 
> I wanted to report that the 
> 
> {"DEC","HSG80","*", BLIST_FORCELUN | BLIST_NOSTARTONADD},
> 
> entry in the device_list[] structure in drivers/scsi/scsi_scan.c is
> incorrect.  It should be
> 
> {"DEC","HSG80","*", BLIST_SPARSELUN | BLIST_LARGELUN |
> BLIST_NOSTARTONADD}

Hi Chad, 

Mind to write a patch for 2.6 and, as soon as its tested there, we can 
backport it to 2.4.

James should handle this.
