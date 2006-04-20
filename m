Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932100AbWDTWeS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932100AbWDTWeS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 18:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932097AbWDTWeS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 18:34:18 -0400
Received: from ishtar.tlinx.org ([64.81.245.74]:20639 "EHLO ishtar.tlinx.org")
	by vger.kernel.org with ESMTP id S932089AbWDTWeR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 18:34:17 -0400
Message-ID: <44480BE7.1060004@tlinx.org>
Date: Thu, 20 Apr 2006 15:32:07 -0700
From: "Linda A. Walsh" <law@tlinx.org>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       chrisw@sous-sol.org, linux-security-module@vger.kernel.org
Subject: Re: [RFC][PATCH 0/11] security: AppArmor - Overview
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com>	<1145470463.3085.86.camel@laptopd505.fenrus.org> <p73mzeh2o38.fsf@bragg.suse.de>
In-Reply-To: <p73mzeh2o38.fsf@bragg.suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> Anyways, I guess the bigger issue is with hard links anyways
> (Chris gave a long list of other ways to get aliases in path names
> earlier). Discussing those might be much more fruitful.
Can't speak to a list I haven't seen, but hard links are not
a problem.  Hard links can only be used within a volume.  Simply
place all your allowed executables on one partition/volume. 
Perhaps it is mounted read/only from a DVD or over an NFS share.
Hard links become a non problem if users can't write to the volume
that the files reside on.

Linda

