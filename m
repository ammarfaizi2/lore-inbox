Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267358AbUG2JhN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267358AbUG2JhN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 05:37:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267379AbUG2JhN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 05:37:13 -0400
Received: from smtp.irisa.fr ([131.254.254.26]:15042 "EHLO smtp.irisa.fr")
	by vger.kernel.org with ESMTP id S267358AbUG2JhM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 05:37:12 -0400
Message-ID: <4108C548.2020008@irisa.fr>
Date: Thu, 29 Jul 2004 11:37:12 +0200
From: Guillaume POIRIER <guillaume.poirier@irisa.fr>
Organization: IRISA, France
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040413 Debian/1.6-5
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: reiser4, kallsyms_lookup, 2.6.7-mm7
References: <200407281506.12876.norberto+linux-kernel@bensa.ath.cx>
In-Reply-To: <200407281506.12876.norberto+linux-kernel@bensa.ath.cx>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Norberto Bensa wrote:

 > Hello everyone,
 >
 > well, just out of curiosity (I wanted to play with reiser4) I've 
patched my 2.6.7-mm7 tree; no rejects. But I get this:
 >
 > *** Warning: "kallsyms_lookup" [fs/reiser4/reiser4.ko] undefined!
 >
 > How do I get around that warning?

Is there any #include <linux/kallsyms.h>
in any of the top files of this patch?
