Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293486AbSCEQ7B>; Tue, 5 Mar 2002 11:59:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293504AbSCEQ6u>; Tue, 5 Mar 2002 11:58:50 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:62222 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S293486AbSCEQ6V>; Tue, 5 Mar 2002 11:58:21 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC] Arch option to touch newly allocated pages
Date: 5 Mar 2002 08:57:41 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a62te5$qp0$1@cesium.transmeta.com>
In-Reply-To: <20020304232806.A31622@redhat.com> <200203051443.JAA02119@ccure.karaya.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <200203051443.JAA02119@ccure.karaya.com>
By author:    Jeff Dike <jdike@karaya.com>
In newsgroup: linux.dev.kernel
> 
> The other reason I don't like this is that, at some point, I'd like to
> start thinking about userspace cooperating with the kernel on memory
> management.  UML looks like a perfect place to start since it's essentially
> identical to the host making it easier for the two to bargain over memory.
> 
> Having UML react sanely to unbacked pages is a step in that direction, having
> UML preemptively grab all the memory it could ever use isn't.
> 

Until you can come up with a sane application for it, this is just
featuritis.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
