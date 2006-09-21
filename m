Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750862AbWIUAld@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750862AbWIUAld (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 20:41:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750864AbWIUAld
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 20:41:33 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:27343 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750861AbWIUAlc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 20:41:32 -0400
Date: Wed, 20 Sep 2006 17:41:23 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Rohit Seth <rohitseth@google.com>
cc: Andi Kleen <ak@suse.de>, CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       devel@openvz.org, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch02/05]: Containers(V2)- Generic Linux kernel changes
In-Reply-To: <1158799073.7207.35.camel@galaxy.corp.google.com>
Message-ID: <Pine.LNX.4.64.0609201740530.2581@schroedinger.engr.sgi.com>
References: <1158718722.29000.50.camel@galaxy.corp.google.com> 
 <p7364fikcbe.fsf@verdi.suse.de>  <1158770670.8574.26.camel@galaxy.corp.google.com>
  <200609202014.48815.ak@suse.de>  <Pine.LNX.4.64.0609201721360.2336@schroedinger.engr.sgi.com>
 <1158799073.7207.35.camel@galaxy.corp.google.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Sep 2006, Rohit Seth wrote:

> ...my preference is to leave it in page struct...that has non-zero cost.

Oh. Making struct page bigger than a cacheline or not fitting exactly in a 
cacheline has some costs.

