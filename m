Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932425AbVKLR2i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932425AbVKLR2i (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 12:28:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932426AbVKLR2i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 12:28:38 -0500
Received: from cantor.suse.de ([195.135.220.2]:56297 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932425AbVKLR2h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 12:28:37 -0500
From: Andi Kleen <ak@suse.de>
To: Nikita Danilov <nikita@clusterfs.com>
Subject: Re: [patch] mark text section read-only
Date: Sat, 12 Nov 2005 18:26:26 +0100
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>,
       Josh Boyer <jdub@us.ibm.com>, akpm@osdl.org
References: <20051107105624.GA6531@infradead.org> <200511112243.42255.ak@suse.de> <17269.10620.891788.767146@gargle.gargle.HOWL>
In-Reply-To: <17269.10620.891788.767146@gargle.gargle.HOWL>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511121826.26979.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 12 November 2005 00:30, Nikita Danilov wrote:
> Andi Kleen writes:
> 
> [...]
> 
>  > 
>  > Overall I doubt it is worth it even as a debugging option. I so far cannot
>  > remember a single bug that was caused by overwriting kernel text.
> 
> I wouldn't forget that one for a long time:
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=106503116306729&w=2

Ok then maybe as a debug CONFIG, but definitely not default.

-Andi
