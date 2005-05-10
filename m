Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261454AbVEJARH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261454AbVEJARH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 20:17:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261458AbVEJARH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 20:17:07 -0400
Received: from wproxy.gmail.com ([64.233.184.196]:1612 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261454AbVEJARE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 20:17:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=J5cSc4yKNGuB0IR65uWoHqfIGIagx2jFJQC4En24ES+Yv5fQm8XJvXm5TxG5onjZ8PDqvbXISsUluK7xkRRBTjt7daxKMImhHmbZgbJ3xc/Zx5wXnTFv/SXVB0Mxqfg+VzE2wLKPBQNrwrkkHSoamHc6jHrpT+aQ0TtPfa6PZhc=
Message-ID: <40f323d0050509171736748ead@mail.gmail.com>
Date: Tue, 10 May 2005 02:17:04 +0200
From: Benoit Boissinot <bboissin@gmail.com>
Reply-To: Benoit Boissinot <bboissin@gmail.com>
To: Bob Gill <gillb4@telusplanet.net>
Subject: Re: Kernel 2.6.12-rc4 and gcc-4.0.0 (datatype issue?)
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1115676539.7849.73.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1115676539.7849.73.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/10/05, Bob Gill <gillb4@telusplanet.net> wrote:
> Hi.  I recently built 2.6.12-rc4 with gcc-4.0.0, and got a few eip's on
> boot (as reported by dmesg).  I have not found the errors affecting the
> system yet (but I haven't tested exhaustively yet either).  If building
> the recent kernels with gcc-4.0.0 is too early, then please disregard
> this message.
> My first guess (as to the nature of the problem) is a conversion problem
> in kernel/sysctl.c (line 1462 or thereabouts)...this:
> 
This is a gcc bug (fixed in newer snapshots)

regards,

Benoit
