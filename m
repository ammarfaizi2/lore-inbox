Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751412AbWH2M1z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751412AbWH2M1z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 08:27:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751427AbWH2M1z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 08:27:55 -0400
Received: from wr-out-0506.google.com ([64.233.184.233]:63278 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751426AbWH2M1y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 08:27:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cyNPUtEvh7M9ZJqHe5RMcQBzDUyMCDo8rvdHU7rm+6EFn4WYc2xrTJdO7utVMbsRnA3brK0n66bLZqBraLGzMJLqk3ilK5Z1siJB5fuDRlZH3wq83qWB4jxtbu3lyGQ0zyYPrA8MLdpFKbzlwOFfRi/XX2nT3iC/EkXXCKUtPRY=
Message-ID: <b6a2187b0608290527l7405b708jdd4c40c7ea09aa14@mail.gmail.com>
Date: Tue, 29 Aug 2006 20:27:46 +0800
From: "Jeff Chua" <jeff.chua.linux@gmail.com>
To: "Jon Escombe" <lists@dresco.co.uk>
Subject: Re: Lenovo T60 - unable to resume from disk with CONFIG_HIGHMEM64G
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <loom.20060829T084849-443@post.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <loom.20060829T084849-443@post.gmane.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/29/06, Jon Escombe <lists@dresco.co.uk> wrote:
>
> Using a Lenovo T60 laptop - suspend to disk has always failed for me on resume.
>
> Through trial and error, I've found that this problem only occurs with
> CONFIG_HIGHMEM64G (the default in a Fedora installation). On a couple of
> occasions I've seen a hang or an oops instead of a reboot. Apologies for the
> poor quality, but an image of the oops screen can be found at
> http://www.dresco.co.uk/debug/resume_from_disk.jpg

I had the same problem on my IBM x60s. In my case, I see no oops. Just
reboot right after resume with CONFIG_HIGHMEM64G=y. Turning off
CONFIG_HIGHMEM64G, problem goes away. Don't know how to fix. Just to
confirm your findings. 2.6.18-rc5 has the same problem.

Thanks,
Jeff.
