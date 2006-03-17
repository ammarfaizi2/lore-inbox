Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932758AbWCQUpF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932758AbWCQUpF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 15:45:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932759AbWCQUpE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 15:45:04 -0500
Received: from mxsf01.cluster1.charter.net ([209.225.28.201]:1969 "EHLO
	mxsf01.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S932758AbWCQUpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 15:45:03 -0500
Message-ID: <441B1FC0.9040100@cybsft.com>
Date: Fri, 17 Mar 2006 14:44:48 -0600
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>, Esben Nielsen <simlo@phys.au.dk>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       Jan Altenberg <tb10alj@tglx.de>,
       Sastien Dugu <sebastien.dugue@bull.net>
Subject: Re: 2.6.16-rc6-rt3
References: <20060314084658.GA28947@elte.hu> <4416C6DD.80209@cybsft.com> <20060314142458.GA21796@elte.hu> <4416F14E.1040708@cybsft.com> <20060317092351.GA18491@elte.hu> <441AE417.1030601@cybsft.com> <20060317203149.GA23069@elte.hu>
In-Reply-To: <20060317203149.GA23069@elte.hu>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * K.R. Foley <kr@cybsft.com> wrote:
> 
>> OK. Tried rt9 with a clean build and still no joy. I've attached the 
>> log which looks like it could be a similar problem?
> 
> seems to be a different one:
> 
>> input: ImPS/2 Generic Wheel Mouse as /class/input/input1
>> Freeing unused kernel memory: 284k freed
>> Could not allocate 8 bytes percpu data
>> sd_mod: Unknown symbol scsi_print_sense_hdr
> 
> could you increase PERCPU_ENOUGH_ROOM in include/linux/percpu.h? (to 
> e.g. 65536)
> 
> 	Ingo
> 
It is already set to that:
#define PERCPU_ENOUGH_ROOM 65536

-- 
   kr
