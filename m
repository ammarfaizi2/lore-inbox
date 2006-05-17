Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932098AbWEQKVz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932098AbWEQKVz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 06:21:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932119AbWEQKVz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 06:21:55 -0400
Received: from cantor2.suse.de ([195.135.220.15]:7056 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932098AbWEQKVz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 06:21:55 -0400
From: Andi Kleen <ak@suse.de>
To: "Deguara, Joachim" <joachim.deguara@amd.com>
Subject: Re: [PATCH] i386/x86_64: Force pci=noacpi on HP XW9300
Date: Wed, 17 May 2006 11:21:01 +0200
User-Agent: KMail/1.8
Cc: "Jeff Garzik" <jeff@garzik.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Linus Torvalds" <torvalds@osdl.org>, "Andrew Morton" <akpm@osdl.org>
References: <2B2475CC03BBA543AF1B9A19AF46443111FFED@sefsexmb1.amd.com>
In-Reply-To: <2B2475CC03BBA543AF1B9A19AF46443111FFED@sefsexmb1.amd.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605171121.02202.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The fix worked for me.  But as I noted, the lspci output changed and
> going back I see the PCI-X bridge went AWOL, though the the SCSI
> controller (part of that bug) is PCI-X non-bridge anyway.  Also I tested
> this with the SLES kernel which IIRC has mmconfig off by default.  So
> Jeff, I am interested to hear how your testing goes.

Didn't you guys tell me earlier the machine doesn't boot without
pci=noacpi and segmentation enabled? And now it suddenly does again?

If it works without that option in all cases the patch can be of course 
dropped.

-Andi (confused) 
