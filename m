Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285589AbSBSTEv>; Tue, 19 Feb 2002 14:04:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288781AbSBSTEl>; Tue, 19 Feb 2002 14:04:41 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:46856 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S285589AbSBSTEc>; Tue, 19 Feb 2002 14:04:32 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] hex <-> int conversion routines.
Date: 19 Feb 2002 11:04:23 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a4u7jn$t5u$1@cesium.transmeta.com>
In-Reply-To: <02021915240900.00635@jakob> <3C7274BE.1030803@evision-ventures.com> <02021919493204.00447@jakob>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <02021919493204.00447@jakob>
By author:    Jakob Kemi <jakob.kemi@telia.com>
In newsgroup: linux.dev.kernel
> 
> GCC doesn't copy const strings, as opposed to other const arrays.
> So it should be fine as it is. GCC also reuse duplicated strings.
> 

It's still manifest once per file, I believe.

I would suggest making the array an extern instead.

  -hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
