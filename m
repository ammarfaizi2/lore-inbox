Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272333AbRHXVS2>; Fri, 24 Aug 2001 17:18:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272334AbRHXVSW>; Fri, 24 Aug 2001 17:18:22 -0400
Received: from relay3.zonnet.nl ([62.58.50.52]:48851 "EHLO smtp03.zonnet.nl")
	by vger.kernel.org with ESMTP id <S272333AbRHXVRg>;
	Fri, 24 Aug 2001 17:17:36 -0400
Message-ID: <3B86C472.DBE32E99@linux-m68k.org>
Date: Fri, 24 Aug 2001 23:17:38 +0200
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Bill Pringlemeir <bpringle@sympatico.ca>
CC: David Woodhouse <dwmw2@infradead.org>, Keith Owens <kaos@ocs.com.au>,
        linux-kernel@vger.kernel.org
Subject: Re: macro conflict
In-Reply-To: <6208.998658929@ocs3.ocs-net> <16800.998659058@redhat.com> <m2k7ztwne7.fsf@sympatico.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> sizeof() test isn't even needed due to promotion.  Just the signs are
> important (afaik) and a test for pointer and integral mixing which I
> cann't think of.  Maybe some clever use of arrays or "+ *x" or
> something.

Try '-W' or '-Wsign-compare'. pointer/integer compare already results in
a warning without any option.

bye, Roman
