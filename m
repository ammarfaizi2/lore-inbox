Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262573AbTJNQuy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 12:50:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262581AbTJNQuy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 12:50:54 -0400
Received: from pizda.ninka.net ([216.101.162.242]:8092 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262573AbTJNQuw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 12:50:52 -0400
Date: Tue, 14 Oct 2003 09:44:24 -0700
From: "David S. Miller" <davem@redhat.com>
To: Richard J Moore <rasman@uk.ibm.com>
Cc: karim@opersys.com, jmorris@redhat.com, zanussi@us.ibm.com,
       linux-kernel@vger.kernel.org, bob@watson.ibm.com
Subject: Re: [PATCH][RFC] relayfs (1/4) (Documentation)
Message-Id: <20031014094424.6cff5697.davem@redhat.com>
In-Reply-To: <200310141132.28339.rasman@uk.ibm.com>
References: <Pine.LNX.4.44.0310091311440.14415-100000@thoron.boston.redhat.com>
	<200310122323.48885.rasman@uk.ibm.com>
	<20031013102520.0671a69d.davem@redhat.com>
	<200310141132.28339.rasman@uk.ibm.com>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Oct 2003 11:32:28 +0000
Richard J Moore <rasman@uk.ibm.com> wrote:

> Interesting, that assumes sequential processing, if not semi-synchronous 
> processing of events on the receiver side, which is far from guaranteed when 
> considering low-level tracing especially for flight-recorder applications.  

With netlink you may receive the data asynchronously however you
wish after you've requested a dump.

I would like to ask that you go study how netlink works and is used
by things like routing daemons before we discuss this further as
it looks to me like half the conversation is going to be showing
you how netlink works.  And hey there's even an RFC on netlink :)
