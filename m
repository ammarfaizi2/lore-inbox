Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263128AbVCKCrD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263128AbVCKCrD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 21:47:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263130AbVCKCqo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 21:46:44 -0500
Received: from mx1.redhat.com ([66.187.233.31]:29133 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263320AbVCKCnF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 21:43:05 -0500
Date: Thu, 10 Mar 2005 21:43:00 -0500
From: Dave Jones <davej@redhat.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: AGP bogosities
Message-ID: <20050311024259.GD20697@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
References: <16944.62310.967444.786526@cargo.ozlabs.ibm.com> <20050311021248.GA20697@redhat.com> <1110508541.32525.314.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1110508541.32525.314.camel@gaston>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2005 at 01:35:40PM +1100, Benjamin Herrenschmidt wrote:
 > 
 > > 
 > > This part I'm not so sure about.
 > > The pci_get_class() call a few lines above will get a refcount that
 > > we will now never release.
 > 
 > We will ... on the next loop iteration when we call pci_get_class again.

Ohhh, duh. Yes. now I follow.

		Dave

