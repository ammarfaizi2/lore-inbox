Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932623AbWCGCkE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932623AbWCGCkE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 21:40:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932624AbWCGCkE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 21:40:04 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:49795 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S932623AbWCGCkD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 21:40:03 -0500
Date: Mon, 6 Mar 2006 18:44:22 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, serue@us.ibm.com, frankeh@watson.ibm.com,
       clg@fr.ibm.com, Herbert Poetzl <herbert@13thfloor.at>,
       Sam Vilain <sam@vilain.net>
Subject: Re: [RFC][PATCH 4/6] sysvsem: containerize
Message-ID: <20060307024422.GJ27645@sorel.sous-sol.org>
References: <20060306235248.20842700@localhost.localdomain> <20060306235251.04FABF95@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060306235251.04FABF95@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Dave Hansen (haveblue@us.ibm.com) wrote:
> @@ -112,15 +114,12 @@ int sem_ctls[4] = {SEMMSL, SEMMNS, SEMOP
>  #define sc_semopm	(sem_ctls[2])
>  #define sc_semmni	(sem_ctls[3])

Minor one, but didn't see an attempt to handle these sem_ctls global sysctls.

thanks,
-chris
