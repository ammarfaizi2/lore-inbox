Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937696AbWLFWAG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937696AbWLFWAG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 17:00:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937699AbWLFWAG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 17:00:06 -0500
Received: from mail.suse.de ([195.135.220.2]:56182 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937696AbWLFWAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 17:00:05 -0500
From: Andi Kleen <ak@suse.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [linux-usb-devel] [RFC][PATCH 0/2] x86_64 Early usb debug port  support.
Date: Wed, 6 Dec 2006 22:59:45 +0100
User-Agent: KMail/1.9.5
Cc: David Brownell <david-b@pacbell.net>, yinghai.lu@amd.com,
       stuge-linuxbios@cdy.org, stepan@coresystems.de, linuxbios@linuxbios.org,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       gregkh@suse.de
References: <5986589C150B2F49A46483AC44C7BCA4907290@ssvlexmb2.amd.com> <200612062224.33482.ak@suse.de> <m1y7pk4sfa.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1y7pk4sfa.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612062259.46140.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > However I suppose it would be ok to switch Eric's code between early
> > pci access and locked one once the PCI subsystem is up and running.
> > Just don't forget bust_spinlocks()
> 
> No pci access on that path.

Hmm good point. Ok ignore that then.

keep should be default then.

-Andi
