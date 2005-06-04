Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261358AbVFDQLf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261358AbVFDQLf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Jun 2005 12:11:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261360AbVFDQLf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Jun 2005 12:11:35 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:28667 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261358AbVFDQLe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Jun 2005 12:11:34 -0400
Date: Sat, 4 Jun 2005 19:33:01 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: Andrew Morton <akpm@osdl.org>, Alan Stern <stern@rowland.harvard.edu>,
       "Eric W. Biederman" <ebiederm@xmission.com>, Greg KH <greg@kroah.com>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [Fastboot] Re: [RFC/PATCH] Kdump: Disabling PCI interrupts in capture kernel
Message-ID: <20050604140301.GC7439@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20050603112524.GB7022@in.ibm.com> <20050603182147.GB5751@kroah.com> <m13brz9tkf.fsf@ebiederm.dsl.xmission.com> <200506041618.24736.vda@ilport.com.ua> <20050604134306.GB7439@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050604134306.GB7439@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 04, 2005 at 07:13:06PM +0530, Dipankar Sarma wrote:
> That said, I am not sure what is the issue with the console
> drivers. What good is the irq for the console driver if
> it hasn't requested for it ? Why should disabling it affect
> consoles ? The interrupt will get enabled as soon as the driver
> requests for it as per Vivek's patch. Am I missing something here ?

Doh! The answer is in earlier emails - fw controlled pci consoles.

Thanks
Dipankar
