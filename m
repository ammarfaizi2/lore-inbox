Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312133AbSCQW7L>; Sun, 17 Mar 2002 17:59:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312130AbSCQW7B>; Sun, 17 Mar 2002 17:59:01 -0500
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:14865 "EHLO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S312133AbSCQW6t>; Sun, 17 Mar 2002 17:58:49 -0500
Date: Sun, 17 Mar 2002 23:58:38 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: SCSI-Problem with AM53C974
Message-ID: <20020317225838.GA11721@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <200203171439.g2HEdwX00738@orion.steiner.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200203171439.g2HEdwX00738@orion.steiner.local>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Mar 2002, Marion Steiner wrote:

> There is a problem with the AM53C974 Scsi-driver (Revision 0.5, 
> kernel 2.4.x) and the DawiControl DC-2974.
> 
> Mar 17 14:13:01 orion kernel: scsi : aborting command due to timeout : pid
> 123, scsi1, channel 0, id 0, lun 0 Inquiry 00 0
> Mar 17 14:13:03 orion kernel: SCSI host 1 abort (pid 123) timed out -
> resetting
> Mar 17 14:13:03 orion kernel: SCSI bus is being reset for host 1 channel 0.

Command timeouts rather look like bus termination problem, plug loose or
something like that. Does the problem still occur with all cables
unplugged from the DC-2974? Does the problem occur with the DC-2974 in
a different computer?
