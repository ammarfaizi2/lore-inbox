Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261161AbVGTGRl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261161AbVGTGRl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 02:17:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261196AbVGTGRk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 02:17:40 -0400
Received: from smtp105.sbc.mail.re2.yahoo.com ([68.142.229.100]:10117 "HELO
	smtp105.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S261161AbVGTGRk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 02:17:40 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Stephen Evanchik <evanchsa@gmail.com>
Subject: Re: Synaptics and TrackPoint problems in 2.6.12
Date: Wed, 20 Jul 2005 01:17:33 -0500
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org
References: <a71293c2050719204047bd2afe@mail.gmail.com>
In-Reply-To: <a71293c2050719204047bd2afe@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507200117.33852.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 19 July 2005 22:40, Stephen Evanchik wrote:
> Dimitry,
> 
> I have been receiving a lot of complaints that TrackPoints on
> Synaptics pass-thru ports stopped working with 2.6.12. I retested
> 2.6.9 and 2.6.11-rc3 successfully, I believe 2.6.11.7 may also work
> but that is unconfirmed at this point.
> 
> The behavior is always the same .. after sending the read secondary ID
> command, the TrackPoint seems to be disabled from that point forward.
> 
> Any ideas?
> 

Not really... You know, I am reviewing the 2.6.12 patch and don't really
see anything that might have caused the problem you are describing. I know
that not all devices on pass-through ports are broken since I have one
(not TrackPoint, just a simple eraser head pointer) and I make sure it
works ;)

When you are talking about reading secondary ID, are you talking about
TP_READ_ID or something else?

Are you experiencing the breakage yourself? It might be interesting to
see the log with i8042 debugging turned on.

-- 
Dmitry
