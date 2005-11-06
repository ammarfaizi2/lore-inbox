Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932223AbVKFRip@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932223AbVKFRip (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 12:38:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932242AbVKFRip
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 12:38:45 -0500
Received: from smtp-100-sunday.nerim.net ([62.4.16.100]:27918 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S932223AbVKFRio
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 12:38:44 -0500
Date: Sun, 6 Nov 2005 18:38:49 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Edgar Hucek <hostmaster@ed-soft.at>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: New Linux Development Model
Message-Id: <20051106183849.68775b66.khali@linux-fr.org>
In-Reply-To: <436DEF22.4010903@ed-soft.at>
References: <436C7E77.3080601@ed-soft.at>
	<20051105122958.7a2cd8c6.khali@linux-fr.org>
	<436CB162.5070100@ed-soft.at>
	<5a2cf1f60511060252t55e1a058o528700ea69826965@mail.gmail.com>
	<436DEF22.4010903@ed-soft.at>
X-Mailer: Sylpheed version 2.0.3 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Edgar,

> It's frustrating for the user, have on the one side the
> new hardware supported but on the other side, mybe broken support for
> the existing hardware.
> (...)
> So you wanna say a new "stable" kernel isn't a realy a stable one
> and i can't relay that it behaves like the older one ? If it's so, then
> something is completely wrong in kernel development.

"stable" is a relative notion. It's a tradeoff between improvements and
the lack of regression. What you are asking for is absolute stability.
This can only be achieved by the absolute lack of change. As soon as
any change is made to the kernel, there is a risk of regression. Blame
it on the complexity and variety of computer hardware.

It is our collective belief, as the kernel developers, that the current
development model represents the best tradeoff we can achieve. We know,
because we are the ones who suffer the most when the development model
is not efficient.

Having a separate development branch is not a solution. It was
discussed on this list and various other places several times already.
Read the archives. The bottom line is that separate trees increase the
workload on developers and divide the testing efforts, so we're losing
on all fronts.

Let's imagine we have a separate development branch for a minute. This
means we wouldn't be adding new stuff to the stable branch, right? Else
it wouldn't be stable. So, you would complain that the stable branch
doesn't have the latset ipw2200 driver. We would direct you to the
development branch, which has it. You would complain that some drivers
are broken for you in this branch, which is expected to happen in a
development branch. See? Separate branches did not even solve your
problem.

You blame your current problems on the development model, yet you
failed to demonstrate how exactly this development model was
responsible for them, as you failed to propose a different model which
would solve them.

-- 
Jean Delvare
