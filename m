Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261603AbTIKWFa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 18:05:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261606AbTIKWFa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 18:05:30 -0400
Received: from zok.SGI.COM ([204.94.215.101]:24466 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S261603AbTIKWFZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 18:05:25 -0400
Date: Thu, 11 Sep 2003 15:04:34 -0700
To: Andrew de Quincey <adq_dvb@lidskialf.net>
Cc: andrew.grover@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] deal with lack of acpi prt entries gracefully
Message-ID: <20030911220434.GA28095@sgi.com>
Mail-Followup-To: Andrew de Quincey <adq_dvb@lidskialf.net>,
	andrew.grover@intel.com, linux-kernel@vger.kernel.org
References: <20030909201310.GB6949@sgi.com> <200309112213.13263.adq_dvb@lidskialf.net> <20030911212059.GA27063@sgi.com> <200309112300.30882.adq_dvb@lidskialf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309112300.30882.adq_dvb@lidskialf.net>
User-Agent: Mutt/1.5.4i
From: jbarnes@sgi.com (Jesse Barnes)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 11, 2003 at 11:00:30PM +0100, Andrew de Quincey wrote:
> > None of the above.  We have our own NUMAlink based interrupt protocol
> > model.
> 
> Oooer! Hmm, the existing code would probably NOT like having _PRT entries for 
> a model it doesn't know about.... you could add support for it fairly easily 
> though I suppose...

Yeah, that's what Andy suggested too.  I guess I have to use one of the
reserved fields and try to get the ACPI spec updated.

Thanks,
Jesse
