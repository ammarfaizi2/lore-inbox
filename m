Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129541AbRB0HfI>; Tue, 27 Feb 2001 02:35:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129599AbRB0He7>; Tue, 27 Feb 2001 02:34:59 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:64522 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129546AbRB0Hew> convert rfc822-to-8bit; Tue, 27 Feb 2001 02:34:52 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: ISO-8859-1 completeness of kernel fonts?
Date: 26 Feb 2001 23:34:42 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <97flai$h60$1@cesium.transmeta.com>
In-Reply-To: <F281raFC8XymNMDdckH00012e6f@hotmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Content-Transfer-Encoding: 8BIT
X-MIME-Autoconverted: from 8bit to quoted-printable by deepthought.transmeta.com id XAA28385
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <F281raFC8XymNMDdckH00012e6f@hotmail.com>
By author:    "Mack Stevenson" <mackstevenson@hotmail.com>
In newsgroup: linux.dev.kernel
>
> Hello,
> 
> The 8x16 and Sun 12x22 kernel fonts I tried seem to lack some standard 
> glyphs necessary to represent the entire ISO-8859-1 charmap; I am talking 
> about all accented capital vowels except for 'É'.
> 
> This seems to happen in both 2.2.16 as well as in 2.2.18.
> 
> Is this intentional? If so, why?
> 
> How can I override this behaviour?
> 

They're probably CP 437 fonts.  Just load your own; e.g. "setfont lat1u-16".

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
