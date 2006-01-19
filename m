Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422639AbWASVGt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422639AbWASVGt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 16:06:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422641AbWASVGs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 16:06:48 -0500
Received: from wproxy.gmail.com ([64.233.184.195]:23400 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1422639AbWASVGs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 16:06:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aBGExapOllZ7o6JyftvEze2t4QP/ijiQqYYDY6pbcP0nlBnUZxnH1rcWIHEaaUjmWioUIvMC2Sz4fzOTG7QpmLaxoIfpFptXsytooFdfIhfk04GkiYSKbfUnS1DHAlxsQfv2njKv2QqRC3WCqaoGpzMON7Ln41n4cUGBzApboQc=
Message-ID: <9a8748490601191306q75b101b5g488aee398d420a00@mail.gmail.com>
Date: Thu, 19 Jan 2006 22:06:47 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: RFC: OSS driver removal, a slightly different approach
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, perex@suse.cz
In-Reply-To: <20060119174600.GT19398@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060119174600.GT19398@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/19/06, Adrian Bunk <bunk@stusta.de> wrote:
[snip]
> My proposed timeline is:
[snip]
> - after the release of 2.6.17 (and before 2.6.18):
>   remove the subset of drivers marked at OBSOLETE_OSS_DRIVER without
>   known regressions in the ALSA drivers for the same hardware

May I suggest you also update the "When" part of this entry in
Documentation/feature-removal-schedule.txt :

What:   drivers depending on OBSOLETE_OSS_DRIVER
When:   January 2006
Why:    OSS drivers with ALSA replacements
Who:    Adrian Bunk <bunk@stusta.de>

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
