Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161020AbWAXSfq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161020AbWAXSfq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 13:35:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932482AbWAXSfq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 13:35:46 -0500
Received: from mx1.redhat.com ([66.187.233.31]:11145 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932484AbWAXSfp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 13:35:45 -0500
Date: Tue, 24 Jan 2006 13:34:32 -0500
From: Dave Jones <davej@redhat.com>
To: Martin Michlmayr <tbm@cyrius.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Export symbols so CONFIG_INPUT works as a module
Message-ID: <20060124183432.GA27917@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Martin Michlmayr <tbm@cyrius.com>, linux-kernel@vger.kernel.org
References: <20060124181945.GA21955@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060124181945.GA21955@deprecation.cyrius.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2006 at 06:19:45PM +0000, Martin Michlmayr wrote:
 > Currently, modular input support fails to load with the following error:
 > 
 > qube:# modprobe input
 > input: Unknown symbol kobject_get_path
 > input: Unknown symbol add_input_randomness
 > 
 > In the short run, this can be solved by exporting these two symbols.
 > There have been discussions about fixing this in a different manner,
 > see http://www.ussg.iu.edu/hypermail/linux/kernel/0505.2/1068.html
 > Since this was in the days of 2.6.12-rc4 and modular input support is
 > still broken, I suggest these symbols to be exported for now.

Is there actually any practical reason why you would want to
make the input layer modular ?

		Dave

