Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263540AbUGICu4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263540AbUGICu4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 22:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263555AbUGICu4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 22:50:56 -0400
Received: from holomorphy.com ([207.189.100.168]:19689 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263540AbUGICuz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 22:50:55 -0400
Date: Thu, 8 Jul 2004 19:50:46 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: nickpiggin@yahoo.com.au, petero2@telia.com, linux-kernel@vger.kernel.org
Subject: Re: Can't make use of swap memory in 2.6.7-bk19
Message-ID: <20040709025046.GU21066@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, nickpiggin@yahoo.com.au,
	petero2@telia.com, linux-kernel@vger.kernel.org
References: <m2brir9t6d.fsf@telia.com> <40ECADF8.7010207@yahoo.com.au> <20040708023001.GN21066@holomorphy.com> <m2briq7izk.fsf@telia.com> <20040708193956.GO21066@holomorphy.com> <40EDED5D.80605@yahoo.com.au> <20040709015317.GR21066@holomorphy.com> <40EDFDBE.5040805@yahoo.com.au> <20040709020905.GT21066@holomorphy.com> <20040708191254.2475c8d1.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040708191254.2475c8d1.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>> Enumerate those more basic things.

On Thu, Jul 08, 2004 at 07:12:54PM -0700, Andrew Morton wrote:
> 1: work out why it's prematurely calling out_of_memory() when laptop_mode=1.

The obvious difference in writeback policy.

I've apparently touched on policy, and paid for that mistake with an
overpoweringly Sterculian whiff of penguins. Now backing away slowly...


-- wli
