Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317214AbSFKXeR>; Tue, 11 Jun 2002 19:34:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317253AbSFKXeQ>; Tue, 11 Jun 2002 19:34:16 -0400
Received: from zeus.kernel.org ([204.152.189.113]:33750 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S317214AbSFKXeP>;
	Tue, 11 Jun 2002 19:34:15 -0400
Date: Wed, 12 Jun 2002 01:29:04 +0200
From: Dave Jones <davej@suse.de>
To: Paolo Ciarrocchi <ciarrocchi@linuxmail.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5.21] compile error
Message-ID: <20020612012904.B30504@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Paolo Ciarrocchi <ciarrocchi@linuxmail.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020611213324.19589.qmail@linuxmail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2002 at 05:33:24AM +0800, Paolo Ciarrocchi wrote:
 > Hi all,
 > I've just tried to compile the 2.5.21,
 > but I got these errors:
 > 
 >    ataraid.c:101: dereferencing pointer to incomplete type

Old news. ataraid hasn't been touched since the block layer
first started getting mangling in 2.5, and hence needs quite
a bit of work.

See http://www.codemonkey.org.uk/Linux-2.5.html for this, and more.

        Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
