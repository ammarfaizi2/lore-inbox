Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261438AbSJMGhW>; Sun, 13 Oct 2002 02:37:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261439AbSJMGhW>; Sun, 13 Oct 2002 02:37:22 -0400
Received: from dp.samba.org ([66.70.73.150]:21652 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261438AbSJMGhV>;
	Sun, 13 Oct 2002 02:37:21 -0400
Date: Sun, 13 Oct 2002 16:42:25 +1000
From: Anton Blanchard <anton@samba.org>
To: "David S. Miller" <davem@redhat.com>
Cc: rth@twiddle.net, wli@holomorphy.com, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [lart] /bin/ps output
Message-ID: <20021013064225.GA22645@krispykreme>
References: <20021012040959.GE7050@krispykreme> <20021011.235329.116353173.davem@redhat.com> <20021012131501.C25740@twiddle.net> <20021012.232744.10131509.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021012.232744.10131509.davem@redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Good idea, well on SMP it can be marked throw-away (ie. __init_data).

We could also only create per cpu data areas when cpu_possible() is
true, instead of NR_CPUS worth. That might be a little dangerous however.

Anton
