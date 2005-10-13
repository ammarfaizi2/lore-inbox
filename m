Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750731AbVJMJJp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750731AbVJMJJp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 05:09:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750785AbVJMJJp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 05:09:45 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:28623 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750731AbVJMJJo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 05:09:44 -0400
Subject: Re: [PATCH 2.6.14-rc4-git] s390, ccw - export modalias
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Andrew Morton <akpm@osdl.org>
Cc: Bastian Blank <bastian@waldi.eu.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20051012125939.6ee58910.akpm@osdl.org>
References: <20051012192639.GA25481@wavehammer.waldi.eu.org>
	 <20051012125939.6ee58910.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 13 Oct 2005 11:09:38 +0200
Message-Id: <1129194579.5305.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-10-12 at 12:59 -0700, Andrew Morton wrote:
> Bastian Blank <bastian@waldi.eu.org> wrote:
> >
> > This patch exports modalias for ccw devices.
> 
> And why do we want to do that?

The wanted to have some information for use by udev. After looking at
the patch I wonder why they can't use the cutype/devtype attributes.
They already contain the information that gets exported by the new
attribute. It might be a little bit harder to parse because devtype can
be "n/a" but that certainly isn't rocket science.

-- 
blue skies,
   Martin

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH


