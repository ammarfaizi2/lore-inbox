Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932345AbWABKDq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932345AbWABKDq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 05:03:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932346AbWABKDq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 05:03:46 -0500
Received: from wproxy.gmail.com ([64.233.184.195]:4900 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932345AbWABKDp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 05:03:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:organization:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=qBM+ZeaTs7JIo5ZUDl/wddsHxkKTZW9/u/Ghdx2ixHqdl4Wmax0sQb4SE/05jAouHVZ1ZarvRKlh1dxxpv6qOZtbzeokg6E1mphmEFAt0mwETZ7akQYkYk5FA0hPuKXjOHdLZdogpVPBEwB+dNh6UqlHV+4PBoWGBTaz2hVISzg=
Message-ID: <43B8FA70.2090408@gmail.com>
Date: Mon, 02 Jan 2006 12:03:28 +0200
From: Matan Peled <chaosite@gmail.com>
Reply-To: chaosite@gmail.com
Organization: Chaosite Destruction, inc.
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.12) Gecko/20051014 Thunderbird/1.0.7 Mnenhy/0.7.2.0
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: kwall@kurtwerks.com
Subject: Re: Arjan's noinline Patch
References: <20060101155710.GA5213@kurtwerks.com> <20060102034350.GD5213@kurtwerks.com>
In-Reply-To: <20060102034350.GD5213@kurtwerks.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kurt Wall wrote:
> the "noinline" cases were built with Arjan's patch and
> CONFIG_CC_OPTIMIZE_FOR_SIZE; the "inline" kernels were built,
> obviously, without the patch and without CONFIG_CC_OPTIMIZE_FOR_SIZE.

Wait, so how do we know if its GCC's -Os that caused the reduction in .text 
size, or the noinline patch ... ?

To get actual results, you should either take OPTIMIZE_FOR_SIZE out the equation 
or use it on the other kernel as well...

-- 
[Name      ]   ::  [Matan I. Peled    ]
[Location  ]   ::  [Israel            ]
[Public Key]   ::  [0xD6F42CA5        ]
[Keyserver ]   ::  [keyserver.kjsl.com]
encrypted/signed  plain text  preferred

