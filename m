Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750772AbWEDSjD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750772AbWEDSjD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 14:39:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750776AbWEDSjD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 14:39:03 -0400
Received: from mx1.redhat.com ([66.187.233.31]:53687 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750772AbWEDSjC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 14:39:02 -0400
Date: Thu, 4 May 2006 14:38:40 -0400
From: Dave Jones <davej@redhat.com>
To: dtor_core@ameritech.net
Cc: "Martin J. Bligh" <mbligh@mbligh.org>, Pavel Machek <pavel@ucw.cz>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Remove silly messages from input layer.
Message-ID: <20060504183840.GE18962@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, dtor_core@ameritech.net,
	"Martin J. Bligh" <mbligh@mbligh.org>, Pavel Machek <pavel@ucw.cz>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20060504024404.GA17818@redhat.com> <20060504071736.GB5359@ucw.cz> <445A18D8.1030502@mbligh.org> <d120d5000605041134k3d9f5934ne9e01f7108cb0271@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d5000605041134k3d9f5934ne9e01f7108cb0271@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 04, 2006 at 02:34:34PM -0400, Dmitry Torokhov wrote:

 > >Perhaps it should say that then ;-)
 > 
 > Do you have a beter wording in mind? "Keyboard reports too many keys
 > were pessed at once, some keystrokes might be dropped"?

It still doesn't make sense when the user only pressed a single key,
or in some cases, never pressed *any* key (don't have that report to hand,
but it was a laptop keyboard)

 > Also I don't understand what people have against this message, it's at
 > KERN_DEBUG level after all.

When you're on the recieving end of distro kernel bug reports, it becomes clearer :)
Users read dmesg from time to time, and freak out when they see something
like this that looks like an error that they can't do anything about.
Until I silenced these in the Fedora kernel I was getting quite a few reports
from concerned users.

		Dave
-- 
http://www.codemonkey.org.uk
