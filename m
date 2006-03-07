Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750754AbWCGFJy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754AbWCGFJy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 00:09:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750763AbWCGFJy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 00:09:54 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:16542 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750754AbWCGFJx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 00:09:53 -0500
Subject: Re: [RFC][PATCH 4/6] sysvsem: containerize
From: Dave Hansen <haveblue@us.ibm.com>
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, serue@us.ibm.com, frankeh@watson.ibm.com,
       clg@fr.ibm.com, Herbert Poetzl <herbert@13thfloor.at>,
       Sam Vilain <sam@vilain.net>
In-Reply-To: <20060307024422.GJ27645@sorel.sous-sol.org>
References: <20060306235248.20842700@localhost.localdomain>
	 <20060306235251.04FABF95@localhost.localdomain>
	 <20060307024422.GJ27645@sorel.sous-sol.org>
Content-Type: text/plain
Date: Mon, 06 Mar 2006 21:08:53 -0800
Message-Id: <1141708133.9274.79.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-03-06 at 18:44 -0800, Chris Wright wrote:
> * Dave Hansen (haveblue@us.ibm.com) wrote:
> > @@ -112,15 +114,12 @@ int sem_ctls[4] = {SEMMSL, SEMMNS, SEMOP
> >  #define sc_semopm	(sem_ctls[2])
> >  #define sc_semmni	(sem_ctls[3])
> 
> Minor one, but didn't see an attempt to handle these sem_ctls global sysctls.

Nope, haven't gotten to those yet.  Thanks for pointing them out.  

-- Dave

