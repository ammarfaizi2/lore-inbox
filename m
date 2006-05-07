Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751211AbWEGIHV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211AbWEGIHV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 May 2006 04:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751216AbWEGIHU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 May 2006 04:07:20 -0400
Received: from nz-out-0102.google.com ([64.233.162.197]:33505 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751211AbWEGIHT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 May 2006 04:07:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from;
        b=X8bcXt4CrrQrkflgEzw5ePeH9+cP52A/rHJc8IspA+HUNNm/kFnHskd/jmxP3/X/Op8iqYkk58q72atTckRlfXzzmzm2sD3qJzuR8HvAsrimCD/5HgfyVEP2z2snG3mQadEsvybr5OgJngln9spMnYdx0Pqejw74f+tc9kbHQIw=
Date: Sun, 7 May 2006 04:07:16 -0400
To: Nuri Jawad <lkml@jawad.org>
Cc: Martin Bligh <mbligh@mbligh.org>, Dave Jones <davej@redhat.com>,
       Martin Mares <mj@ucw.cz>, Pavel Machek <pavel@ucw.cz>,
       dtor_core@ameritech.net, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Remove silly messages from input layer.
Message-ID: <20060507080715.GA8216@nineveh.rivenstone.net>
Mail-Followup-To: Nuri Jawad <lkml@jawad.org>,
	Martin Bligh <mbligh@mbligh.org>, Dave Jones <davej@redhat.com>,
	Martin Mares <mj@ucw.cz>, Pavel Machek <pavel@ucw.cz>,
	dtor_core@ameritech.net,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20060504183840.GE18962@redhat.com> <20060505103123.GB4206@elf.ucw.cz> <20060505152748.GA22870@redhat.com> <mj+md-20060505.153608.7268.albireo@ucw.cz> <20060505154638.GE22870@redhat.com> <mj+md-20060505.154834.7444.albireo@ucw.cz> <20060505160009.GB25883@redhat.com> <Pine.LNX.4.64.0605052131580.28721@pc> <445BB050.4040309@mbligh.org> <Pine.LNX.4.64.0605052218370.9702@pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0605052218370.9702@pc>
User-Agent: Mutt/1.5.11
From: jfannin@gmail.com (Joseph Fannin)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 05, 2006 at 10:30:00PM +0200, Nuri Jawad wrote:
>
> It is useful to show you what kind of environment many users do not want
> to have. Hiding information is not user-friendly for the experienced user,
> only for the novice.

    Spamming my logs with these messages so often that my dmesg buffer
soon contains nothing but and I have to use grep -v to read my syslog
is not user-friendly, and I am hardly a novice.

    At most, a reworded message should be emitted on the first
occurance of the error and not again until a reboot.  If you want to
know more, there are debugging tools for that sort of thing.

--
Joseph Fannin
jhf@rivenstone.net

 /* So there I am, in the middle of my `netfilter-is-wonderful'
talk in Sydney, and someone asks `What happens if you try
to enlarge a 64k packet here?'. I think I said something
eloquent like `fuck'. - RR */
