Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751200AbWDXT74@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200AbWDXT74 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 15:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbWDXT74
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 15:59:56 -0400
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:39651 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S1751200AbWDXT74 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 15:59:56 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: Michael Holzheu <HOLZHEU@de.ibm.com>
Subject: Re: [PATCH/RFC] s390: Hypervisor File System
Date: Mon, 24 Apr 2006 21:57:18 +0200
User-Agent: KMail/1.9.1
References: <OF346B0EC4.22389E6C-ON4225715A.00553273-4225715A.005EFC07@de.ibm.com>
In-Reply-To: <OF346B0EC4.22389E6C-ON4225715A.00553273-4225715A.005EFC07@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, mschwid2@de.ibm.com,
       "Pekka Enberg" <penberg@cs.helsinki.fi>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604242157.19120.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On Monday, 24. April 2006 19:17, you wrote:
> I agree that it is a good idea to specify the characters to
> reject, but I would like to use the function without having an
> additional local pointer variable. In my opinion this
> functionality is enough for most cases.

AFAIK there is no Standard for this kind of functions.

Yes, it might be ok, if you like to destroy the string.
But I prefer non-destructive string handling :-)

Might be a matter of taste. So go wild, if nobody else objects.


Regards

Ingo Oeser
