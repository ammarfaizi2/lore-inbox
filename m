Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262562AbTD3XpU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 19:45:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262563AbTD3XpU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 19:45:20 -0400
Received: from tomts12.bellnexxia.net ([209.226.175.56]:3052 "EHLO
	tomts12-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S262562AbTD3XpS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 19:45:18 -0400
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.5.68-mm3
Date: Wed, 30 Apr 2003 19:57:58 -0400
User-Agent: KMail/1.5.9
References: <20030429235959.3064d579.akpm@digeo.com>
In-Reply-To: <20030429235959.3064d579.akpm@digeo.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200304301957.58729.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On April 30, 2003 02:59 am, Andrew Morton wrote:
> Bits and pieces.  Nothing major, apart from the dynamic request allocation
> patch.  This arbitrarily increases the maximum requests/queue to 1024, and
> could well make large (and usually bad) changes to various benchmarks.
> However some will be helped.

Here is something a little broken.  Suspect it might be in 68-bk too:

if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.68-mm3; fi
WARNING: /lib/modules/2.5.68-mm3/kernel/sound/oss/cs46xx.ko needs unknown symbol cs4x_ClearPageReserved

Ed Tomlinson
