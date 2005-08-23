Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932269AbVHWS2n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932269AbVHWS2n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 14:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932272AbVHWS2m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 14:28:42 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:20645 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S932269AbVHWS2m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 14:28:42 -0400
Date: Tue, 23 Aug 2005 20:24:05 +0200
From: bert hubert <bert.hubert@netherlabs.nl>
To: Davy Durham <pubaddr2@davyandbeth.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: select() efficiency / epoll
Message-ID: <20050823182405.GA21301@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <bert.hubert@netherlabs.nl>,
	Davy Durham <pubaddr2@davyandbeth.com>, linux-kernel@vger.kernel.org
References: <42E162B6.2000602@davyandbeth.com> <20050722212454.GB18988@outpost.ds9a.nl> <430AF11A.5000303@davyandbeth.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <430AF11A.5000303@davyandbeth.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2005 at 04:49:14AM -0500, Davy Durham wrote:

> However, I'm getting segfaults because some pointers in places are 
> getting set to low integer values (which didn't used to have those values).

epoll is pretty heavily benchmarked and hence tested. I don't entirely
understand the remark above and suggest looking at the generated core dumps.

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://netherlabs.nl              Open and Closed source services
