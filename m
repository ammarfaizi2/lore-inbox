Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030290AbWGMTGk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030290AbWGMTGk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 15:06:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030296AbWGMTGk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 15:06:40 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:15076 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030290AbWGMTGj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 15:06:39 -0400
Subject: Re: [patch] lockdep: annotate mm/slab.c
From: Arjan van de Ven <arjan@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       sekharan@us.ibm.com, linux-kernel@vger.kernel.org, nagar@watson.ibm.com,
       balbir@in.ibm.com
In-Reply-To: <Pine.LNX.4.64.0607131147530.5623@g5.osdl.org>
References: <1152763195.11343.16.camel@linuxchandra>
	 <20060713071221.GA31349@elte.hu> <20060713002803.cd206d91.akpm@osdl.org>
	 <20060713072635.GA907@elte.hu> <20060713004445.cf7d1d96.akpm@osdl.org>
	 <20060713124603.GB18936@elte.hu>
	 <Pine.LNX.4.64.0607131147530.5623@g5.osdl.org>
Content-Type: text/plain
Date: Thu, 13 Jul 2006 21:06:29 +0200
Message-Id: <1152817589.3024.64.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-07-13 at 11:50 -0700, Linus Torvalds wrote:
> 
> Why isn't the "on_slab_key" local to just the init_lock_keys()
> function, 
> and the #ifdef around it all?

it's the same net results; the variable is 0 bytes in size for !LOCKDEP 


