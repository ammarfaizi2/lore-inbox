Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262584AbTEFLlY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 07:41:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262590AbTEFLlY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 07:41:24 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:55206
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262584AbTEFLlX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 07:41:23 -0400
Subject: Re: [PATCH 2.4.20] alloc_kiovec performance improvement
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mikael Starvik <mikael.starvik@axis.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       Sebastian =?ISO-8859-1?Q?Sj=F6berg?= <sebastian.sjoberg@axis.com>
In-Reply-To: <3C6BEE8B5E1BAC42905A93F13004E8AB017DEB2E@mailse01.axis.se>
References: <3C6BEE8B5E1BAC42905A93F13004E8AB017DEB2E@mailse01.axis.se>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052218512.28796.20.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 06 May 2003 11:55:12 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-05-05 at 17:54, Mikael Starvik wrote:
> alloc_kiovec always allocates 1024 buffer heads which is a waste 
> with performance in the cases when the buffers aren't used.

See the patches in -ac that came from tuning Oracle performance. 

