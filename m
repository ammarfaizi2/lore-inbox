Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317961AbSGZSSI>; Fri, 26 Jul 2002 14:18:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317965AbSGZSSI>; Fri, 26 Jul 2002 14:18:08 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:53496 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S317961AbSGZSSH>; Fri, 26 Jul 2002 14:18:07 -0400
Subject: Re: Looking for links: Why Linux Doesn't Page Kernel Memory?
From: Robert Love <rml@tech9.net>
To: Russell Lewis <spamhole-2001-07-16@deming-os.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3D418DFD.8000007@deming-os.org>
References: <3D418DFD.8000007@deming-os.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8.99 
Date: 26 Jul 2002 11:21:20 -0700
Message-Id: <1027707680.2442.33.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-07-26 at 10:59, Russell Lewis wrote:

> I have spent some time working on AIX, which pages its kernel memory. 
>  It pins the interrupt handler functions, and any data that they access, 
> but does not pin the other code.
> 
> I'm looking for links as to why (unless I'm mistaken) Linux doesn't do 
> this, so I can better understand the system.

Better question is, why would we have page-able kernel memory?

It complicates kernel-space drastically for little gain.  It is not that
we cannot, or there is a specific technical reason why not - just an
issue of taste.  And lack of drugs.

	Robert Love

