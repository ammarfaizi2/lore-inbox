Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932077AbWICUDl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932077AbWICUDl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 16:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932078AbWICUDl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 16:03:41 -0400
Received: from smtp3.nextra.sk ([195.168.1.142]:29195 "EHLO mailhub3.nextra.sk")
	by vger.kernel.org with ESMTP id S932077AbWICUDk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 16:03:40 -0400
From: Ondrej Zary <linux@rainbow-software.org>
To: Patrick McHardy <kaber@trash.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Oops after 30 days of uptime
Date: Sun, 3 Sep 2006 22:03:22 +0200
User-Agent: KMail/1.9.4
References: <200609011852.39572.linux@rainbow-software.org>
In-Reply-To: <200609011852.39572.linux@rainbow-software.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609032203.23003.linux@rainbow-software.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Friday 01 September 2006 19:00, Patrick McHardy wrote:
> > Ondrej Zary wrote:
> > > Hello,
> > > my home router crashed after about a month. It does this sometimes but
> > > this time I was able to capture the oops. Here is the result of running
> > > ksymoops on it (took a photo of the screen and then manually converted
> > > to plain-text). Does it look like a bug or something other?
> > >
> > >
> > > Code;  c01eeb9e <init_or_cleanup+15e/160>
> > > 00000000 <_EIP>:
> > > Code;  c01eeb9e <init_or_cleanup+15e/160>   <=====
> > >    0:   8b 5e 18                  mov    0x18(%esi),%ebx   <=====
> > > Code;  c01eeba1 <ip_conntrack_protocol_register+1/70>
> > >    3:   11 d8                     adc    %ebx,%eax
> >
> > This looks like a bug in some out of tree protocol module (2.4 only
> > contains the built-in protocols). Did you apply any netfilter patches?
>
> No patches, it's clean 2.4.31.
> Hopefully I typed all the numbers correctly...

Checked all numbers and it's correct. Can this be a hardware problem?

-- 
Ondrej Zary

-- 
VGER BF report: H 0
