Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263246AbTAJGnj>; Fri, 10 Jan 2003 01:43:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263256AbTAJGni>; Fri, 10 Jan 2003 01:43:38 -0500
Received: from mail.zmailer.org ([62.240.94.4]:28829 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id <S263246AbTAJGnh>;
	Fri, 10 Jan 2003 01:43:37 -0500
Date: Fri, 10 Jan 2003 08:52:18 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: "David D. Hagood" <wowbagger@sktc.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Asterisk] DTMF noise
Message-ID: <20030110065218.GE27709@mea-ext.zmailer.org>
References: <D6889804-2291-11D7-901B-000393950CC2@karlsbakk.net> <3E1BD88A.4080808@users.sf.net> <3E1C1CDE.8090600@sktc.net> <3E1C4872.7080508@gmx.net> <3E1D705E.1030203@sktc.net> <3E1D79CB.5010503@gmx.net> <3E1E06A3.8050607@sktc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E1E06A3.8050607@sktc.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2003 at 05:32:51PM -0600, David D. Hagood wrote:
> Well, I found out that while we have the DTMF test tape at work, it is 
> exactly that - a cassette tape that is copyrighted. So, no easy/legal 
> way to make it available for testing...

What does such tape contain ?
 - DTMF tones buried in various degrees of distortions,
   which should be decodable ?
 - DTMF tones buried in varying noises which should not be
   decodable ?
 - Other multi-tone signals which should not decode ?

For the last, I know of cases where test was done by playing a radio 
station on the decoder for 2-3 days, and seeing when does it trigger
DTMFs (if ever).

For that matter, the Linux kernel ISDN audio DTMF detection is exactly
of the last variant.

/Matti Aarnio
