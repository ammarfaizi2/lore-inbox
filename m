Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282978AbSA0BLU>; Sat, 26 Jan 2002 20:11:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287436AbSA0BLL>; Sat, 26 Jan 2002 20:11:11 -0500
Received: from tapu.cryptoapps.com ([63.108.153.39]:48313 "EHLO tapu.f00f.org")
	by vger.kernel.org with ESMTP id <S282978AbSA0BLB>;
	Sat, 26 Jan 2002 20:11:01 -0500
Date: Sat, 26 Jan 2002 17:09:56 -0800
From: Chris Wedgwood <cw@f00f.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Really odd behavior of overlapping named pipes?
Message-ID: <20020127010724.GB8125@tapu.f00f.org>
In-Reply-To: <20020126021610.YKAU20810.femail29.sdc1.sfba.home.com@there> <a2trjq$h2r$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2trjq$h2r$1@cesium.transmeta.com>
User-Agent: Mutt/1.3.27i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 26, 2002 at 01:07:06AM -0800, H. Peter Anvin wrote:

    It sounds like what you're expecting is what would happen if we
    allowed open() on a Unix domain socket to do the obvious thing (can
    we, pretty please?)

Why?  Do any other OS's support this?  It seems pointless if it's
nonportable, but, if for arguments sake, several other OSs provide
this then I guess we could for compatability reasons... and I assume
with this proposal open would be jost socket/connect --- accept
behavior would still require accept?



  --cw
