Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751396AbWDYFam@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751396AbWDYFam (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 01:30:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751395AbWDYFam
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 01:30:42 -0400
Received: from fw5.argo.co.il ([194.90.79.130]:28178 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S1751292AbWDYFam (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 01:30:42 -0400
Message-ID: <444DB3FC.3070802@argo.co.il>
Date: Tue, 25 Apr 2006 08:30:36 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@mbligh.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Compiling C++ modules
References: <B9FF2DE8-2FE8-4FE1-8720-22FE7B923CF8@iomega.com> <1145911546.1635.54.camel@localhost.localdomain> <444D3D32.1010104@argo.co.il> <444DA2CA.4060807@mbligh.org>
In-Reply-To: <444DA2CA.4060807@mbligh.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Apr 2006 05:30:39.0967 (UTC) FILETIME=[638B76F0:01C66829]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
>
> So ... what exactly are you waiting for? We await the results with
> baited breath. This slick C++ kernel of which you speak can surely
> not be far away.
>
I'll start on converting 2.6.16 tomorrow, since you're anticipating it 
with such eagerness. I expect it to take some days. But a few years ago 
I did convert a filesystem in C to C++. The code was shorter, faster, 
and more robust. Fast enough to take the top position in SPEC SFS, and 
robust enough to handle the disks being pulled from under its feet 
(which a very popular Linux filesystem written in C could not at the 
time, and maybe today).

The speed benefits were largely due to algorithmic improvements, not 
language micro-optimizations; however I do claim that C++ allowed much 
faster refactoring, so we could focus our efforts on algorithms instead 
of finding our way in ever-more-convoluted error paths.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

