Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262041AbTKYNyM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 08:54:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262074AbTKYNyM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 08:54:12 -0500
Received: from jaguar.mkp.net ([192.139.46.146]:2234 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id S262041AbTKYNyL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 08:54:11 -0500
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Alexander Viro <viro@math.psu.edu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, jbarnes@sgi.com, steiner@sgi.com
Subject: Re: hash table sizes
References: <16323.23221.835676.999857@gargle.gargle.HOWL>
	<20031125134222.GA8039@holomorphy.com>
From: Jes Sorensen <jes@wildopensource.com>
Date: 25 Nov 2003 08:54:03 -0500
In-Reply-To: <20031125134222.GA8039@holomorphy.com>
Message-ID: <yq0fzgcimf8.fsf@wildopensource.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "William" == William Lee Irwin <wli@holomorphy.com> writes:

William> On Tue, Nov 25, 2003 at 08:35:49AM -0500, Jes Sorensen wrote:
>> + mempages >>= (23 - (PAGE_SHIFT - 1)); + order = max(2,
>> fls(mempages)); + order = min(12, order);

William> This is curious; what's 23 - (PAGE_SHIFT - 1) supposed to
William> represent?

Well MB >> 2 or consider it trial and error ;-)

Cheers,
Jes
