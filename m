Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263861AbTFGWFq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 18:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263865AbTFGWFq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 18:05:46 -0400
Received: from terminus.zytor.com ([63.209.29.3]:4773 "EHLO terminus.zytor.com")
	by vger.kernel.org with ESMTP id S263861AbTFGWFp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 18:05:45 -0400
Message-ID: <3EE264C5.6060703@zytor.com>
Date: Sat, 07 Jun 2003 15:18:45 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030211
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Maximum swap space?
References: <ltptlqb72n.fsf@colina.demon.co.uk> <33435.4.64.196.31.1055008200.squirrel@www.osdl.org> <bbtmaq$r03$1@cesium.transmeta.com> <20030607214950.GI8978@holomorphy.com>
In-Reply-To: <20030607214950.GI8978@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> 
> The 2GB limit is 100% userspace; distros are already shipping the
> mkswap(8) fixes (both RH & UL anyway).
> 

Presumably it means they have defined a new swap format and have changed 
swapon(8) as well.  This should be rolled back into util-linux if they 
aren't already.

	-hpa


