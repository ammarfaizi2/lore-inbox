Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932443AbWFHBZc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932443AbWFHBZc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 21:25:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932279AbWFHBZc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 21:25:32 -0400
Received: from cantor.suse.de ([195.135.220.2]:8389 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932275AbWFHBZb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 21:25:31 -0400
From: Andi Kleen <ak@suse.de>
To: Joachim Fritschi <jfritschi@freenet.de>
Subject: Re: [PATCH  1/4] Twofish cipher - split out common c code
Date: Thu, 8 Jun 2006 03:15:15 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
       herbert@gondor.apana.org.au
References: <200606041516.21967.jfritschi@freenet.de> <200606072137.24176.jfritschi@freenet.de>
In-Reply-To: <200606072137.24176.jfritschi@freenet.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606080315.15067.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 07 June 2006 21:37, Joachim Fritschi wrote:
> On Sunday 04 June 2006 15:16, Joachim Fritschi wrote:
> > I have revised my initial twofish assembler patchset according to the 
> > criticims i recieved on this list:
> > This patch splits up the twofish crypto routine into a common part ( key 
> > setup  ) which will be uses by all twofish crypto modules ( generic-c , i586 
> > assembler and x86_64 assembler ) and generic-c part. It also creates a new 
> > header file which will be used by all 3 modules. 
> > This eliminates all code duplication.
> > Correctness was verified with the tcrypt module and automated test scripts.
> My first mail was wordwrapped. This one should be unwrapped and working:

Thanks I merged them all now.

-Andi
