Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751126AbVJFQEF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbVJFQEF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 12:04:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751127AbVJFQEF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 12:04:05 -0400
Received: from xproxy.gmail.com ([66.249.82.192]:13734 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751126AbVJFQED convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 12:04:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=A6gDXsTyAxaf0NgyM0+W8VUaHQw6XZji7U7/JB7Fq+Yq9zww1frddgTF87Iqkg+hpQdVzndqd952Yu/rfSjnEznJeR8Dnoq/Z4sWJjQAzObriA0zpiYgc9+7cpbiFufhe8tRHXhPlJWr1pvYIMNlTz7MqjpnhCVB0PnT9aJWe0I=
Message-ID: <5bdc1c8b0510060904w5d8d14e1w46690337cb86ca5c@mail.gmail.com>
Date: Thu, 6 Oct 2005 09:04:02 -0700
From: Mark Knecht <markknecht@gmail.com>
Reply-To: Mark Knecht <markknecht@gmail.com>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.14-rc3-rt2
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051006083339.GA22224@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5bdc1c8b0510041111n188b8e14lf5a1398406d30ec4@mail.gmail.com>
	 <5bdc1c8b0510041158m3620f5dcy2dafda545ad3cd5e@mail.gmail.com>
	 <1128458707.13057.68.camel@tglx.tec.linutronix.de>
	 <5bdc1c8b0510041349g1a4f2484qd17a11812c8ccac3@mail.gmail.com>
	 <20051005105605.GA27075@elte.hu>
	 <5bdc1c8b0510051014q3bb02d5bl80d2c88cc884fe35@mail.gmail.com>
	 <Pine.LNX.4.58.0510060403210.28535@localhost.localdomain>
	 <20051006081055.GA20491@elte.hu>
	 <Pine.LNX.4.58.0510060425561.28535@localhost.localdomain>
	 <20051006083339.GA22224@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/6/05, Ingo Molnar <mingo@elte.hu> wrote:
>
> * Steven Rostedt <rostedt@goodmis.org> wrote:
>
> > So I guess these patches need to go upstream too?
> >
> > Here's the rest of the u32 coversions. Not all the u32 flags were used
> > for spinlocks. Most were for the flags instance in the structure.
> >
> > Note, this patch does _NOT_ include the previous patch that I sent.
> > If this needs to go upstream, I'll send the two together as one patch.
>
> in any case i've applied both patches to the -rt tree.
>
>         Ingo
>

Ingo,
   As of -rt10 this morning I am no longer getting my accounting bug
report in dmesg. Thanks!

- Mark
