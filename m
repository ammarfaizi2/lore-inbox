Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261157AbULDU75@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261157AbULDU75 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Dec 2004 15:59:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261158AbULDU75
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Dec 2004 15:59:57 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:11962 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261157AbULDU74
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Dec 2004 15:59:56 -0500
Date: Sat, 4 Dec 2004 20:59:54 +0000
From: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
To: Miguel Angel Flores <maf@sombragris.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] aic7xxx large integer
Message-ID: <20041204205954.GA1188@gallifrey>
References: <41B222BE.9020205@sombragris.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41B222BE.9020205@sombragris.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/2.6.5 (i686)
X-Uptime: 20:58:54 up  8:24,  1 user,  load average: 0.00, 0.02, 0.00
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Miguel Angel Flores (maf@sombragris.com) wrote:
> Hi all,
> 
> I noticed a large integer warning when compiling 2.6.10rc3 with the SCSI 
> AIC-7xxx driver.
>  
> -	mask_39bit = 0x7FFFFFFFFFULL;
> +	mask_39bit = 0x7FFFFFFF;

Hmm - I can't help but think that perhaps
'mask_39bit' was intended to be a 39 bit mask.

Dave

 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM,SPARC,PPC & HPPA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
