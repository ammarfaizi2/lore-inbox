Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030219AbVKCATM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030219AbVKCATM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 19:19:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030220AbVKCATM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 19:19:12 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:2010 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1030219AbVKCATL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 19:19:11 -0500
Date: Thu, 3 Nov 2005 01:19:10 +0100 (CET)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Nathan Scott <nathans@sgi.com>
Cc: Jan Kasprzak <kas@fi.muni.cz>, linux-kernel@vger.kernel.org,
       linux-xfs@oss.sgi.com
Subject: Re: XFS information leak during crash
In-Reply-To: <20051103101107.O6239737@wobbly.melbourne.sgi.com>
Message-ID: <Pine.LNX.4.62.0511030116160.2023@artax.karlin.mff.cuni.cz>
References: <20051102212722.GC6759@fi.muni.cz> <20051103101107.O6239737@wobbly.melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> either). Does XFS support a something like ext3's "data=ordered" mount
>> option?
>
> No, it doesn't.

BTW. Why does it sometimes overwrite files with zeros after crash and 
journal replay then? I thought that this was because it tries to avoid 
users seeing uninitialized data.

Mikulas
