Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264765AbTCFBPB>; Wed, 5 Mar 2003 20:15:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267686AbTCFBOw>; Wed, 5 Mar 2003 20:14:52 -0500
Received: from bi01p1.co.us.ibm.com ([32.97.110.142]:27448 "EHLO w-patman.des")
	by vger.kernel.org with ESMTP id <S264765AbTCFBOq>;
	Wed, 5 Mar 2003 20:14:46 -0500
Date: Wed, 5 Mar 2003 17:13:47 -0800
From: Patrick Mansfield <patmans@us.ibm.com>
To: Andries.Brouwer@cwi.nl
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       torvalds@transmeta.com
Subject: Re: 2.5.63/64 do not boot: loop in scsi_error
Message-ID: <20030305171347.A17467@beaverton.ibm.com>
References: <UTC200303060101.h2611cg08660.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <UTC200303060101.h2611cg08660.aeb@smtp.cwi.nl>; from Andries.Brouwer@cwi.nl on Thu, Mar 06, 2003 at 02:01:38AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries -

On Thu, Mar 06, 2003 at 02:01:38AM +0100, Andries.Brouwer@cwi.nl wrote:
> See that 2.5.64 came out - good. Time to send the next dev_t patch.
> Unfortunately 2.5.63 and 2.5.64 do not boot.

Did you try the patch to scsi_error.c Mike A. recently posted?

> [I can make 2.5.64 boot if I make sure no errors ever occur.
> That means that I must disable get_evpd_page, get_serialnumber,
> get_cachetype that my old stuff doesnt know about.
> If I do that all is well.]

That sucks - even if error handling recovers from them.

-- Patrick Mansfield
