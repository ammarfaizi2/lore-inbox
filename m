Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262235AbVBQG0L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262235AbVBQG0L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 01:26:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262236AbVBQGZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 01:25:57 -0500
Received: from one.firstfloor.org ([213.235.205.2]:36492 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S262235AbVBQGZu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 01:25:50 -0500
To: Mike Snitzer <snitzer@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fwd: dm perf scales poorly with 2.6.x kernel
References: <170fa0d205021520083b24c1b6@mail.gmail.com>
	<170fa0d20502161504f8db91b@mail.gmail.com>
From: Andi Kleen <ak@muc.de>
Date: Thu, 17 Feb 2005 07:25:48 +0100
In-Reply-To: <170fa0d20502161504f8db91b@mail.gmail.com> (Mike Snitzer's
 message of "Wed, 16 Feb 2005 16:04:57 -0700")
Message-ID: <m14qgb3doz.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Snitzer <snitzer@gmail.com> writes:
>
> Ultimately there appears to be a disproportionate increase in the DM
> performance hit as the IO throughput capability of the underlying
> block device increases (I'm obviously using a limited sampling so...).
>  But given the current results it is clear there will be a performance
> hit associated with using DM; but having that hit be fixed as the
> throughput scales would be ideal.

You could do a oprofile run to see where to CPU time is going to
and post the results.

-Andi
