Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129421AbRCEQxn>; Mon, 5 Mar 2001 11:53:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129449AbRCEQxe>; Mon, 5 Mar 2001 11:53:34 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:31757 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129421AbRCEQx1>; Mon, 5 Mar 2001 11:53:27 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: binfmt_script and ^M
Date: 5 Mar 2001 08:53:03 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <980g9f$jo$1@cesium.transmeta.com>
In-Reply-To: <20010305095512.A30787@tux.gsfc.nasa.gov> <Pine.LNX.3.95.1010305102226.9913A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.3.95.1010305102226.9913A-100000@chaos.analogic.com>
By author:    "Richard B. Johnson" <root@chaos.analogic.com>
In newsgroup: linux.dev.kernel
> 
> The '\r' (^R) definitely has special significance to Unix. It's called
> "VREPRINT", in the termios structure member "c_cc".
>

'\r' is ^M, not ^R.

> There is really no such thing as  "whitespace" in Unix compatible text.
> For instance, the text in a Makefile MUST use the tab character as a
> separator. Spaces won't do.

Whitespace is defined by POSIX as '\n', '\r', '\t', '\v', '\f' or ' '.
Occationally, the specific *kind* of whitespace matters -- for
example, '\n' frequently have different behaviour; as does '\t' in
make.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
