Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932350AbWCRJlF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932350AbWCRJlF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 04:41:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932355AbWCRJlF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 04:41:05 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:48278 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932350AbWCRJlD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 04:41:03 -0500
Date: Sat, 18 Mar 2006 10:38:53 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Patch 2 of 8] annotate the PDA structure with offsets
Message-ID: <20060318093853.GA28846@elte.hu>
References: <1142611850.3033.100.camel@laptopd505.fenrus.org> <1142611989.3033.107.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1142611989.3033.107.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Arjan van de Ven <arjan@linux.intel.com> wrote:

> Change the comments in the pda structure to make the first fields to 
> have their offset documented (the rest of the fields follows in a 
> later patch) and to have the comments aligned

i think offset 40 should be build-time checked - then you dont have to 
do this annotation.

	Ingo 
