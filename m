Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751312AbWDTU5A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751312AbWDTU5A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 16:57:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751313AbWDTU5A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 16:57:00 -0400
Received: from smtp13.wanadoo.fr ([193.252.22.54]:43709 "EHLO
	smtp13.wanadoo.fr") by vger.kernel.org with ESMTP id S1751311AbWDTU47
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 16:56:59 -0400
X-ME-UUID: 20060420205657655.9FFF37000087@mwinf1302.wanadoo.fr
Date: Thu, 20 Apr 2006 22:55:55 +0200
From: Mathieu Chouquet-Stringer <mchouque@free.fr>
To: Bob Tracy <rct@gherkin.frus.com>, linux-kernel@vger.kernel.org,
       linux-alpha@vger.kernel.org, rth@twiddle.net
Subject: Re: strncpy (maybe others) broken on Alpha
Message-ID: <20060420205555.GA11502@bigip.bigip.mine.nu>
Mail-Followup-To: Mathieu Chouquet-Stringer <mchouque@free.fr>,
	Bob Tracy <rct@gherkin.frus.com>, linux-kernel@vger.kernel.org,
	linux-alpha@vger.kernel.org, rth@twiddle.net
References: <20060419213129.GA9148@localhost> <20060419215803.6DE5BDBA1@gherkin.frus.com> <20060420101448.GA20087@localhost> <20060420171102.GA7272@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060420171102.GA7272@localhost>
User-Agent: Mutt/1.4.2.1i
X-Face: %JOeya=Dg!}[/#Go&*&cQ+)){p1c8}u\Fg2Q3&)kothIq|JnWoVzJtCFo~4X<uJ\9cHK'.w 3:{EoxBR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2006 at 07:11:02PM +0200, Mathieu Chouquet-Stringer wrote:
> And here's the output using gcc version 3.4.4 (Gentoo 3.4.4-r1,
> ssp-3.4.4-1.0, pie-8.7.8), note i didn't use flag except -Wall:

Same code compiled with 2.95.3 fails too (I'll be trying 4.1.0 just for
the kick of it, if it cross-compiles ok but I don't expect it to work
either).


PS: Richard, we're having troubles with at least one of your function
(strncpy) on alpha.  It appears it doesn't copy the source string
properly.
You can read a recap of the thread here:
http://groups.google.com/group/linux.kernel/browse_thread/thread/551729237671f997/11109932eae9fd93?tvc=2&q=group%3A*kernel*+strncpy+mathieu#11109932eae9fd93
-- 
Mathieu Chouquet-Stringer                           mchouque@free.fr

