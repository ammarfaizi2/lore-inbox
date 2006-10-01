Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932418AbWJAVeF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932418AbWJAVeF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 17:34:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932420AbWJAVeF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 17:34:05 -0400
Received: from cavan.codon.org.uk ([217.147.92.49]:42955 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S932418AbWJAVeC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 17:34:02 -0400
Date: Sun, 1 Oct 2006 22:34:00 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] - add PNP IDs for FPI based touchscreens
Message-ID: <20061001213400.GA18756@srcf.ucam.org>
References: <20061001182738.GA17124@srcf.ucam.org> <1159735659.13029.182.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1159735659.13029.182.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 01, 2006 at 09:47:39PM +0100, Alan Cox wrote:
> Acked-by: Alan Cox <alan@redhat.com>
> 
> This makes a lot of sense and will mean that people don't have to read
> the fpit driver docs to get X working.

Sadly, there's still a need to provide the calibration values. These all 
seem to be available in the .inf files from the Windows drivers, and 
keying off the PNPID /seems/ to be adequate to determine which values to 
use. If I ever find my copious free time, I'll look into that.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
