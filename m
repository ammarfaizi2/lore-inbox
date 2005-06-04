Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261272AbVFDVVD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261272AbVFDVVD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Jun 2005 17:21:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261282AbVFDVVD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Jun 2005 17:21:03 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:30633 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261272AbVFDVU5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Jun 2005 17:20:57 -0400
To: dipankar@in.ibm.com
Cc: Denis Vlasenko <vda@ilport.com.ua>, Andrew Morton <akpm@osdl.org>,
       Alan Stern <stern@rowland.harvard.edu>, Greg KH <greg@kroah.com>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [Fastboot] Re: [RFC/PATCH] Kdump: Disabling PCI interrupts in capture kernel
References: <20050603112524.GB7022@in.ibm.com>
	<20050603182147.GB5751@kroah.com>
	<m13brz9tkf.fsf@ebiederm.dsl.xmission.com>
	<200506041618.24736.vda@ilport.com.ua>
	<20050604134306.GB7439@in.ibm.com> <20050604140301.GC7439@in.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 04 Jun 2005 15:14:48 -0600
In-Reply-To: <20050604140301.GC7439@in.ibm.com>
Message-ID: <m11x7h7rjr.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dipankar Sarma <dipankar@in.ibm.com> writes:

> On Sat, Jun 04, 2005 at 07:13:06PM +0530, Dipankar Sarma wrote:
> > That said, I am not sure what is the issue with the console
> > drivers. What good is the irq for the console driver if
> > it hasn't requested for it ? Why should disabling it affect
> > consoles ? The interrupt will get enabled as soon as the driver
> > requests for it as per Vivek's patch. Am I missing something here ?
> 
> Doh! The answer is in earlier emails - fw controlled pci consoles.

There is still the question do fw controlled pci consoles
intersect with consoles used during kdump.  I would be
very surprised if the intersected but they might.

Eric

