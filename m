Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751401AbWFUT3x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401AbWFUT3x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 15:29:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751436AbWFUT3x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 15:29:53 -0400
Received: from smtp.nildram.co.uk ([195.112.4.54]:62226 "EHLO
	smtp.nildram.co.uk") by vger.kernel.org with ESMTP id S1751401AbWFUT3w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 15:29:52 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Herbert Rosmanith <kernel@wildsau.enemy.org>
Subject: Re: gcc-4.1.1 and kernel-2.4.32
Date: Wed, 21 Jun 2006 20:29:20 +0100
User-Agent: KMail/1.9.3
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org
References: <200606211425.k5LEPtY6012550@wildsau.enemy.org>
In-Reply-To: <200606211425.k5LEPtY6012550@wildsau.enemy.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606212029.20032.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 21 June 2006 15:25, Herbert Rosmanith wrote:
> > In effect (mainline) no. Linux 2.2 and 2.0 won't be fixed for the same
> > reason; called deep maintenance. 2.6 has been on the road since Dec 2003,
> > that's over 2 years. Do away with the old stuff.
>
> we are in the process of switching, which is not unproblematic. on
> the other hand, we have to support existing installations as well.

FWIW, distributions generally let you install older GCCs. Hopefully your 
distribution still has 2.95.3 in its repository, so you could install this to 
get a well tested (and probably smaller code generating) compiler for 2.4 
kernels. gcc -V <version> can be used to switch between them, if your 
distributor opts to install to the same prefix.

-- 
Cheers,
Alistair.

Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
