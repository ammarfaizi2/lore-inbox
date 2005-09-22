Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751451AbVIVIfc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751451AbVIVIfc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 04:35:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751453AbVIVIfc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 04:35:32 -0400
Received: from web33203.mail.mud.yahoo.com ([68.142.206.101]:60065 "HELO
	web33203.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751451AbVIVIfb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 04:35:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.ca;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=3KB+EM8mo3fpqihh4KdbqaKWFOujOu8g7b6SRSAkXbk/xvzmEsJQMtlDrg5W1d6KhX3SQFaA8fgk+Gha0K0EoGWIGO4wWSL/kG2yGhR9W0SqiGiScDc34Tt+jIvY5vRJgV8LwE3CkjhtRHikX/oNJUPdyhCsh+Z3NHMbl5O+EnU=  ;
Message-ID: <20050922083530.52435.qmail@web33203.mail.mud.yahoo.com>
Date: Thu, 22 Sep 2005 04:35:30 -0400 (EDT)
From: rep stsb <repstsb@yahoo.ca>
Subject: Re: In-kernel graphics subsystem 
To: linux-kernel@vger.kernel.org
Cc: Valdis.Kletnieks@vt.edu, 06020051@lums.edu.pk
In-Reply-To: <200509220606.j8M66u8d010990@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Valdis.Kletnieks@vt.edu wrote:


> Wouldn't it make more sense to extend the current
> framebuffer driver
> support to support v-sync? (framebuffers are already
> in the kernel, and
> there were so many security holes with svgalib-based
> programs that it left
> a bad taste in a lot of people's mouths)

I am presently wounded and cannot do either until I
heal.

> And having gotten a v-sync interrupt, what would you
> *do* with it?
> You'll need an API here....

svgalib has a vga_waitrefresh() function. It can be
implemented as a block on, either a ioctl or a read,
on a kernel-space driver, or by polling.

mihai cartoaje


	

	
		
__________________________________________________________ 
Find your next car at http://autos.yahoo.ca
