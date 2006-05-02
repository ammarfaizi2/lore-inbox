Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751176AbWEBTpI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751176AbWEBTpI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 15:45:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbWEBTpI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 15:45:08 -0400
Received: from cantor2.suse.de ([195.135.220.15]:6577 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751176AbWEBTpH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 15:45:07 -0400
From: Andi Kleen <ak@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: assert/crash in __rmqueue() when enabling CONFIG_NUMA
Date: Tue, 2 May 2006 21:44:56 +0200
User-Agent: KMail/1.9.1
Cc: "Martin J. Bligh" <mbligh@mbligh.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
References: <20060419112130.GA22648@elte.hu> <200605021745.32907.ak@suse.de> <20060502194828.GB10072@elte.hu>
In-Reply-To: <20060502194828.GB10072@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605022144.56586.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 02 May 2006 21:48, Ingo Molnar wrote:
> 
> * Andi Kleen <ak@suse.de> wrote:
> 
> > i386: Panic the system early when a NUMA kernel doesn't run on IBM 
> > NUMA
> 
> nah! Lets just fix the zone sizing bug ...

The problem is that nobody regression tests it. So even if you fix it
now it will be likely broken again in a few months.

-Andi
