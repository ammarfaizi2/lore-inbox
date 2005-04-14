Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261568AbVDNRfI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261568AbVDNRfI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 13:35:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261563AbVDNRfI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 13:35:08 -0400
Received: from hockin.org ([66.35.79.110]:15058 "EHLO www.hockin.org")
	by vger.kernel.org with ESMTP id S261568AbVDNRes (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 13:34:48 -0400
Date: Thu, 14 Apr 2005 10:34:38 -0700
From: Tim Hockin <thockin@hockin.org>
To: Ross Biro <ross.biro@gmail.com>
Cc: Dave Jones <davej@redhat.com>, Andi Kleen <ak@muc.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC/Patch 2.6.11] Take control of PCI Master Abort Mode
Message-ID: <20050414173438.GA9488@hockin.org>
References: <4252E827.4080807@google.com> <m14qee221l.fsf@muc.de> <8783be66050412075218b2b0b0@mail.gmail.com> <20050413183725.GG50241@muc.de> <8783be66050413160033e6283d@mail.gmail.com> <20050413232826.GA22698@redhat.com> <8783be66050414102551698d86@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8783be66050414102551698d86@mail.gmail.com>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/13/05, Dave Jones <davej@redhat.com> wrote:

> If we have a situation where we screw a subset of users with the
> config option =y and a different subset with =n, how is this improving
> the situation any over what we have today ?

Dave,

What's a good alternative?  Do we need to keep a whitelist of hardware
that is known to work?  A blacklist is pretty risky, since this is a very
hard problem to find.

What if it was always on, except when the commandlien was passed
(eliminate the CONFIG option)?  Really 'leet hacks could tweak a #define
if they don't like the command line option..

