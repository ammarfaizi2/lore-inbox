Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264658AbUFPTfV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264658AbUFPTfV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 15:35:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264689AbUFPTfU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 15:35:20 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:28914 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S264658AbUFPTfO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 15:35:14 -0400
Message-ID: <40D0A0F0.2040908@mvista.com>
Date: Wed, 16 Jun 2004 12:35:12 -0700
From: Todd Poynor <tpoynor@mvista.com>
User-Agent: Mozilla Thunderbird 0.7a (X11/20040614)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Export pm_suspend
References: <20040616011311.GA9256@slurryseal.ddns.mvista.com> <20040616040758.GA6521@kroah.com>
In-Reply-To: <20040616040758.GA6521@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Tue, Jun 15, 2004 at 06:13:11PM -0700, Todd Poynor wrote:
> 
>>Allow modules to request system suspend via the in-kernel interface, if
>>desired.
> 
> 
> And who would be so desiring?  I don't see any in-kernel code that needs
> this.  Care to also submit the code that needs this?

Sorry, my botched phrasing was intended to read more like "if this would 
be viewed as a good thing".  Since pm_suspend is the "externally visible 
function for suspending system" it seems it might be proper to export it 
for module use as well, much like various APM and software suspend 
functions in the same directory.  We only have test code that uses this, 
so no big deal on our part; I'll send out a call to some designers who 
are building embedded gadgets using pm_suspend() to see if anybody has 
interest in this and code to go along with it.  Thanks -- Todd

