Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265163AbTLaPHW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 10:07:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265164AbTLaPHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 10:07:21 -0500
Received: from holomorphy.com ([199.26.172.102]:54725 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265163AbTLaPGT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 10:06:19 -0500
Date: Wed, 31 Dec 2003 07:06:07 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Paolo Ornati <ornati@lycos.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.1-rc1 [resend]
Message-ID: <20031231150607.GQ27687@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Paolo Ornati <ornati@lycos.it>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0312310033110.30995@home.osdl.org> <200312311434.17036.ornati@lycos.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200312311434.17036.ornati@lycos.it>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 31, 2003 at 04:00:07PM +0100, Paolo Ornati wrote:
> With 2.6.1-rc1 I have noticed a strange IDE performance change.
> Results of "hdparm -t /dev/hda" with 2.6.0 kernel:
> (readahead = 256):		~26.31 MB/s
> (readahead = 128):		~31.82 MB/s
> PS = readahead is set to 256 by default on my system, 128 seems to be the 
> best value
> Results of "hdparm -t /dev/hda" with 2.6.1-rc1 kernel:
> (readahead = 256):		~26.41 MB/s
> (readahead = 128):		~26.27 MB/s
> Setting readahead to 128 doesn't have the same effect with the new kernel...

What io scheduler are you using? Or, could you post /var/log/dmesg?


-- wli
