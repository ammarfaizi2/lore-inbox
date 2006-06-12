Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752036AbWFLPZ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752036AbWFLPZ5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 11:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752038AbWFLPZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 11:25:57 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:1439 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1752036AbWFLPZ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 11:25:57 -0400
Subject: Re: Good performance (hard realtime ??) on 2.6.16 patched with
	patch-2.6.16-rt29 from Ingo Molnar
From: Lee Revell <rlrevell@joe-job.com>
To: Felix Oxley <lkml@oxley.org>
Cc: kernel@wolff-online.nl, linux-kernel@vger.kernel.org
In-Reply-To: <FEBBD28D-B00D-42DB-A2EB-13A501D7FBC2@oxley.org>
References: <20060612095008.21733.qmail@www.wolff-online.nl>
	 <FEBBD28D-B00D-42DB-A2EB-13A501D7FBC2@oxley.org>
Content-Type: text/plain
Date: Mon, 12 Jun 2006 11:26:03 -0400
Message-Id: <1150125964.22720.40.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-12 at 11:12 +0100, Felix Oxley wrote:
> (Regarding Hard Real Time, my understanding is that that depends on a
> _guarantee_ that the system will always be able to produce the  
> 'result' within the required interval. Ingo's -rt patches may give  
> exceedingly good responsiveness but they offer no guarantees, so they
> cannot be considered Hard Real Time) 

The -rt kernel is capable of hard realtime, modulo any bugs, but no one
has yet done an analysis of the few non-preemptible code paths to
determine what guarantees it can make.

Lee

