Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261841AbTCGXDK>; Fri, 7 Mar 2003 18:03:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261853AbTCGXDJ>; Fri, 7 Mar 2003 18:03:09 -0500
Received: from mx12.arcor-online.net ([151.189.8.88]:19086 "EHLO
	mx12.arcor-online.net") by vger.kernel.org with ESMTP
	id <S261841AbTCGXDJ>; Fri, 7 Mar 2003 18:03:09 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
       Pavel Machek <pavel@suse.cz>
Subject: Re: BitBucket: GPL-ed *notrademarkhere* clone
Date: Sun, 9 Mar 2003 00:18:04 +0100
X-Mailer: KMail [version 1.3.2]
References: <200303020011.QAA13450@adam.yggdrasil.com> <20030306164146.GF2781@zaurus.ucw.cz> <b4b4cp$c9u$1@cesium.transmeta.com>
In-Reply-To: <b4b4cp$c9u$1@cesium.transmeta.com>
Cc: opencm-dev@smtp.opencm.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20030307231341.BA07FF9890@mx12.arcor-online.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 07 Mar 03 22:53, H. Peter Anvin wrote:
> I would really, really take a look at opencm first then.  Really.

Untarring and building opencm-0.1.2alpha2-1-src.tgz generated an empty show.c 
file.  Not feeling too imaginative, I did:

-int show_c(SDR_stream *strm, const Buffer *input);
+int show_c(SDR_stream *strm, const Buffer *input) { return 0; }

in Browse.c, and was rewarded with a build.

Is this still on-topic for lkml?

Regards,

Daniel
