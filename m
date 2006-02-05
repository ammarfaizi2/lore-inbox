Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750712AbWBEUNR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbWBEUNR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 15:13:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750713AbWBEUNR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 15:13:17 -0500
Received: from ns2.suse.de ([195.135.220.15]:51095 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750712AbWBEUNR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 15:13:17 -0500
To: Kirill Korotaev <dev@openvz.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 1/5] Virtualization/containers: startup
References: <43E38BD1.4070707@openvz.org>
From: Andi Kleen <ak@suse.de>
Date: 05 Feb 2006 21:13:12 +0100
In-Reply-To: <43E38BD1.4070707@openvz.org>
Message-ID: <p73psm1lg2v.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev <dev@openvz.org> writes:



> +	struct vps_info *owner_vps;

You don't seem to be any ifdefs for anything. I guess that's ok if the
final virtualization will be really light weight (let's say not more
than a few KB of additional memory including runtime overhead). But
somehow I guess it will be heavier. What are the plans to allow to
CONFIG it all out for small systems?

-Andi
