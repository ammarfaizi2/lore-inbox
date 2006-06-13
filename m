Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750706AbWFMILV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750706AbWFMILV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 04:11:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750728AbWFMILV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 04:11:21 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:22157 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1750706AbWFMILU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 04:11:20 -0400
Date: Tue, 13 Jun 2006 11:11:18 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Ingo Molnar <mingo@elte.hu>
cc: Catalin Marinas <catalin.marinas@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.17-rc6 7/9] Remove some of the kmemleak false positives
In-Reply-To: <20060613072646.GA17978@elte.hu>
Message-ID: <Pine.LNX.4.58.0606131109360.15861@sbz-30.cs.Helsinki.FI>
References: <20060611111815.8641.7879.stgit@localhost.localdomain>
 <20060611112156.8641.94787.stgit@localhost.localdomain>
 <84144f020606112219m445a3ccas7a95c7339ca5fa10@mail.gmail.com>
 <b0943d9e0606120111v310f8556k30b6939d520d56d8@mail.gmail.com>
 <Pine.LNX.4.58.0606121111440.7129@sbz-30.cs.Helsinki.FI> <20060612105345.GA8418@elte.hu>
 <b0943d9e0606120556h185f2079x6d5a893ed3c5cd0f@mail.gmail.com>
 <20060612192227.GA5497@elte.hu> <Pine.LNX.4.58.0606130850430.15861@sbz-30.cs.Helsinki.FI>
 <20060613072646.GA17978@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jun 2006, Ingo Molnar wrote:
> This also means that by default we'd have no false positives at all, but 
> that there is a capable annotation method to reduce the amount of false 
> negatives, in a gradual and managable way - down to zero if everything 
> is annotated.

Yeah, sounds much better to me.  However, I am unable to figure out any 
real examples where we'd actually need the annotations for reasonably 
sane code.  Do you have some in mind?

					Pekka
