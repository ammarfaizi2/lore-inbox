Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422954AbWHZCAV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422954AbWHZCAV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 22:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422955AbWHZCAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 22:00:21 -0400
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:1158 "EHLO
	mail.arcor.de") by vger.kernel.org with ESMTP id S1422954AbWHZCAU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 22:00:20 -0400
In-Reply-To: <1156538115.3038.6.camel@pmac.infradead.org>
References: <1156429585.3012.58.camel@pmac.infradead.org> <1156433068.3012.115.camel@pmac.infradead.org> <200608251611.50616.rob@landley.net> <1156538115.3038.6.camel@pmac.infradead.org>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <D02D0DC3-D19E-4411-BD27-5BDC17BD4D21@kernel.crashing.org>
Cc: Rob Landley <rob@landley.net>, linux-kernel@vger.kernel.org,
       linux-tiny@selenic.com, devel@laptop.org
Content-Transfer-Encoding: 7bit
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 0/4] Compile kernel with -fwhole-program --combine
Date: Sat, 26 Aug 2006 03:59:40 +0200
To: David Woodhouse <dwmw2@infradead.org>
X-Mailer: Apple Mail (2.750)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> And you get a nice progress indicator at the moment -- a new warning
> about global register variables every time it eats a new file, due to
> GCC PR27899 :)

Or pass -Q to the compiler, it'll print the name of every function
it compiles, and a nice timing report at the end.


Segher

