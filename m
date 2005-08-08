Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750817AbVHHKe6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817AbVHHKe6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 06:34:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750814AbVHHKe6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 06:34:58 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:36485 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1750817AbVHHKe6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 06:34:58 -0400
References: <20050802071828.GA11217@redhat.com>
            <84144f0205080223445375c907@mail.gmail.com>
            <20050808095747.GD13951@redhat.com>
In-Reply-To: <20050808095747.GD13951@redhat.com>
From: "Pekka J Enberg" <penberg@cs.helsinki.fi>
To: David Teigland <teigland@redhat.com>
Cc: Pekka Enberg <penberg@gmail.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-cluster@redhat.com
Subject: Re: GFS
Date: Mon, 08 Aug 2005 13:34:56 +0300
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="utf-8,iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <courier.42F73550.00004B7B@courier.cs.helsinki.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Teigland writes:
> > Is there a reason why you cannot use <linux/hash.h> or <linux/jhash.h>? 
> 
> See gfs2_hash_more() and comment; we hash discontiguous regions.

jhash() takes an initial value. Isn't that sufficient? 

                 Pekka 

