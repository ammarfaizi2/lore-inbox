Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265334AbUAACaZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 21:30:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265336AbUAACaZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 21:30:25 -0500
Received: from rs9.luxsci.com ([66.216.98.59]:11498 "EHLO rs9.luxsci.com")
	by vger.kernel.org with ESMTP id S265334AbUAACaY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 21:30:24 -0500
Message-ID: <3FF3862C.9060704@acm.org>
Date: Wed, 31 Dec 2003 18:30:04 -0800
From: Javier Fernandez-Ivern <ivern@acm.org>
Reply-To: ivern@acm.org
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michael Clark <michael@metaparadigm.com>
Cc: Dave Jones <davej@redhat.com>, rudi@lambda-computing.de,
       linux-kernel@vger.kernel.org
Subject: Re: File change notification
References: <3FF2FC85.5070906@lambda-computing.de> <3FF31366.30206@acm.org> <3FF31A15.4070307@lambda-computing.de> <3FF377A8.6040302@metaparadigm.com> <20040101015809.GA14930@redhat.com> <3FF38375.2090808@metaparadigm.com>
In-Reply-To: <3FF38375.2090808@metaparadigm.com>
X-Enigmail-Version: 0.82.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Clark wrote:

> Yes I see what you mean after having a look. Would make sense to convert
> this over to use only LSM hooks (which it appears to use already) if that
> was possible - or maybe could be done using a VFS proxy filesystem that
> monitors/relays calls to an underlying fs.

I don't think using LSM hooks for this is a good idea.  While it makes 
the changes less invasive, it forces you to enable LSM just to get file 
  change modifications.

-- 
Javier Fernandez-Ivern
