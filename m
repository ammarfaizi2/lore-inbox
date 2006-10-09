Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932984AbWJIRHd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932984AbWJIRHd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 13:07:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932985AbWJIRHd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 13:07:33 -0400
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:8083 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S932984AbWJIRHc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 13:07:32 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: balagi@justmail.de
Subject: Re: [PATCH 7/11] 2.6.18-mm3 pktcdvd: make procfs interface optional
Date: Mon, 9 Oct 2006 19:07:22 +0200
User-Agent: KMail/1.9.3
Cc: "Peter Osterlund" <petero2@telia.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <op.tguqh5r2iudtyh@master> <m3bqoqmt3e.fsf@telia.com> <op.tg5c8vr2iudtyh@master>
In-Reply-To: <op.tg5c8vr2iudtyh@master>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610091907.23223.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Monday, 9. October 2006 12:05, Thomas Maier wrote:
> Ok, 1k is a little bit high, since only about 300 chars are written
> into the buffer currently.
> But also, pkt_print_info() would only write sizeof(buf) chars into
> the buffer.

What about making pkt_print_info() accept a "struct seq_file *" 
instead and print directly into the seq_file buffer? 


Regards

Ingo Oeser
