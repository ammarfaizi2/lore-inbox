Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263665AbTEYRVy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 13:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263668AbTEYRVy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 13:21:54 -0400
Received: from roc-24-93-20-125.rochester.rr.com ([24.93.20.125]:39159 "EHLO
	mail.kroptech.com") by vger.kernel.org with ESMTP id S263665AbTEYRVv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 13:21:51 -0400
Date: Sun, 25 May 2003 13:06:37 -0400
From: Adam Kropelin <akropel1@rochester.rr.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.69-mm9
Message-ID: <20030525130637.A22232@mail.kroptech.com>
References: <20030525042759.6edacd62.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030525042759.6edacd62.akpm@digeo.com>; from akpm@digeo.com on Sun, May 25, 2003 at 04:27:59AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 25, 2003 at 04:27:59AM -0700, Andrew Morton wrote:
> 
> . 2.5.69-mm9 is not for the timid.  It includes extensive changes to the
>   ext3 filesystem and the JBD layer.  It withstood an hour of testing on my
>   4-way, but it probably has a couple of holes still.

Felt like tempting fate today...

Works nicely here on my 2-way. Survives make -j30 (on a machine without
nearly enough RAM for such foolishness) as well as a basic mysql
stress-test.

--Adam

