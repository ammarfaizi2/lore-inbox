Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262203AbVAECTX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262203AbVAECTX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 21:19:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262200AbVAECTX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 21:19:23 -0500
Received: from quark.didntduck.org ([69.55.226.66]:34783 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP id S262203AbVAECTO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 21:19:14 -0500
Message-ID: <41DB4E99.3060200@didntduck.org>
Date: Tue, 04 Jan 2005 21:19:05 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla Thunderbird  (X11/20041216)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Nelson <james4765@cwazy.co.uk>
CC: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org
Subject: Re: [PATCH 0/7] ppc: remove cli()/sti() from arch/ppc/*
References: <20050104214048.21749.85722.89116@localhost.localdomain>
In-Reply-To: <20050104214048.21749.85722.89116@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Nelson wrote:
> This series of patches is to remove the last cli()/sti() function calls in arch/ppc.
> 
> These are the only instances in active code that grep could find.

Are you sure none of these need real spinlocks instead of just disabling 
interrupts?

--
				Brian Gerst
