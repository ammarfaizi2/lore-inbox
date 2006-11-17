Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755573AbWKQJW1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755573AbWKQJW1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 04:22:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755576AbWKQJW1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 04:22:27 -0500
Received: from ns1.suse.de ([195.135.220.2]:37083 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1755573AbWKQJW0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 04:22:26 -0500
From: Andi Kleen <ak@suse.de>
To: eranian@hpl.hp.com
Subject: Re: [PATCH] i386 add Intel PEBS and BTS cpufeature bits and detection
Date: Fri, 17 Nov 2006 10:22:20 +0100
User-Agent: KMail/1.9.5
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
References: <20061115213241.GC17238@frankl.hpl.hp.com> <200611170529.02460.ak@suse.de> <20061117075750.GA19907@frankl.hpl.hp.com>
In-Reply-To: <20061117075750.GA19907@frankl.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611171022.20708.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The former
> stores from/to information into MSRs and is very small (4 branches). 

P4 since Prescott has 16

> On recent processors LBR and BTS can be constrained by priv level.

Doesn't help for kernel debugging.

-Andi
