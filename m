Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751419AbWAWIUU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751419AbWAWIUU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 03:20:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751424AbWAWIUT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 03:20:19 -0500
Received: from xproxy.gmail.com ([66.249.82.200]:18193 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751419AbWAWIUS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 03:20:18 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RngfL9128IX5RskUMUOGQpWdjgW9/mK8dr46pbj50HkMwo9dPN9qWBIkNUyHjz+VCRhrZ+0d+Bly2BcZl7cFUZ6xafL8rQ6LKkl4HmQXJiXgPTKeA7qohqlLk7kxGBhBD3eSWgEypjD1Z31+lObfnk5y8OAWt5HvyhflYn6uVq8=
Message-ID: <986ed62e0601230020g19dfe825r1b81a2bed411c1fc@mail.gmail.com>
Date: Mon, 23 Jan 2006 00:20:16 -0800
From: "Barry K. Nathan" <barryn@pobox.com>
To: Chase Venters <chase.venters@clientec.com>
Subject: Re: [RFC] VM: I have a dream...
Cc: Michael Loftis <mloftis@wgops.com>, Al Boldi <a1426z@gawab.com>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <200601222346.24781.chase.venters@clientec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200601212108.41269.a1426z@gawab.com>
	 <986ed62e0601221155x6a57e353vf14db02cc219c09@mail.gmail.com>
	 <E3C35184F807ADEC2AD9E182@dhcp-2-206.wgops.com>
	 <200601222346.24781.chase.venters@clientec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/22/06, Chase Venters <chase.venters@clientec.com> wrote:
> Just as a curiosity... does anyone have any guesses as to the runtime
> performance cost of hosting one or more swap files (which thanks to on demand
> creation and growth are presumably built of blocks scattered around the disk)
> versus having one or more simple contiguous swap partitions?
>
> I think it's probably a given that swap partitions are better; I'm just
> curious how much better they might actually be.

If you google "mac os x swap partition", you'll find benchmarks from
several years ago. (Although, those benchmarks are with a partition
dedicated to the dynamically created swap files. It does more or less
ensure that the files are contiguous though.) Mac OS X was *much* more
of a dog back then, in terms of performance, so I don't know how
relevant those benchmarks are nowadays, but it might be a starting
point for answering your question.

--
-Barry K. Nathan <barryn@pobox.com>
