Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263977AbTKSKiZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 05:38:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263980AbTKSKiZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 05:38:25 -0500
Received: from holomorphy.com ([199.26.172.102]:63400 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263977AbTKSKiY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 05:38:24 -0500
Date: Wed, 19 Nov 2003 02:38:15 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Paul Jackson <pj@sgi.com>
Cc: linux-kernel@vger.kernel.org, anton@samba.org, ak@muc.de
Subject: Re: format_cpumask()
Message-ID: <20031119103815.GE19856@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Paul Jackson <pj@sgi.com>, linux-kernel@vger.kernel.org,
	anton@samba.org, ak@muc.de
References: <20031117033504.GC19856@holomorphy.com> <20031119013238.21944da9.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031119013238.21944da9.pj@sgi.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 19, 2003 at 01:32:38AM -0800, Paul Jackson wrote:
> Wouldn't it be a good idea to pass in the length of the remaining
> available buffer space and use snprintf, to avoid overruns?
> We're going to end up with some pretty big cpumasks on some systems --
> running over a buffer would be nasty.  It would mostly happen during
> bring up of new bigger systems; but still worth avoiding.
> A second thought - more controversial - long sequences of digits can get
> pretty difficult to read.  How about breaking them with a separator
> character, say every 32 or 64 bits.

I'm happy just to get the numbers into _some_ format that makes sense.
This could very well be an improvement over the large hexadecimal
number. I say run with it.


-- wli
