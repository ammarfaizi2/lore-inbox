Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030199AbWHXQA1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030199AbWHXQA1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 12:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030217AbWHXQA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 12:00:26 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:30098 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030199AbWHXQAZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 12:00:25 -0400
Subject: Re: [PATCH] BLOCK: Make it possible to disable the block layer
From: David Woodhouse <dwmw2@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: David Howells <dhowells@redhat.com>, Jens Axboe <axboe@suse.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060824155814.GL19810@stusta.de>
References: <32640.1156424442@warthog.cambridge.redhat.com>
	 <20060824152937.GK19810@stusta.de>
	 <1156434274.3012.128.camel@pmac.infradead.org>
	 <20060824155814.GL19810@stusta.de>
Content-Type: text/plain
Date: Thu, 24 Aug 2006 17:00:16 +0100
Message-Id: <1156435216.3012.130.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-24 at 17:58 +0200, Adrian Bunk wrote:
> There's no reason for getting linux-kernel swamped with
> "my kernel doesn't boot" messages by people who accidentally disabled 
> this option.

By that logic, you should make it necessary to set CONFIG_EMBEDDED
before you can set CONFIG_EXT3 != Y or CONFIG_IDE != Y too.

However you dress it up, it's pandering to someone who either lacks the
wit, or just can't be bothered, to _look_ at what they're doing when
they configure their kernel. And it's a bad thing.

-- 
dwmw2

