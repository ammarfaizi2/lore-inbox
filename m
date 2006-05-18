Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751150AbWERA6o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbWERA6o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 20:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751157AbWERA6n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 20:58:43 -0400
Received: from mail.ocs.com.au ([202.147.117.210]:58820 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S1751150AbWERA6n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 20:58:43 -0400
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.1-RC1
From: Keith Owens <kaos@ocs.com.au>
To: Martin Peschke <mp3@de.ibm.com>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Chase Venters <chase.venters@clientec.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       Christoph Lameter <clameter@sgi.com>,
       "Frank Ch. Eigler" <fche@redhat.com>,
       Peter Chubb <peterc@gelato.unsw.edu.au>,
       "hch@infradead.org" <hch@infradead.org>,
       "arjan@infradead.org" <arjan@infradead.org>, "ak@suse.de" <ak@suse.de>
Subject: Re: [RFC] [Patch 5/6] statistics infrastructure 
In-reply-to: Your message of "Wed, 17 May 2006 20:56:20 +0200."
             <1147892180.3076.23.camel@dyn-9-152-230-71.boeblingen.de.ibm.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 18 May 2006 10:57:25 +1000
Message-ID: <3741.1147913845@ocs3>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Peschke (on Wed, 17 May 2006 20:56:20 +0200) wrote:
>This patch adds statistics infrastructure as common code.
>+static int __devinit statistic_hotcpu(struct notifier_block *notifier,
>+				      unsigned long action, void *__cpu)

__cpuinit for hotplug cpu, not __devinit.

