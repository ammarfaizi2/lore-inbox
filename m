Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261514AbSKBXeF>; Sat, 2 Nov 2002 18:34:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261515AbSKBXeF>; Sat, 2 Nov 2002 18:34:05 -0500
Received: from signup.localnet.com ([207.251.201.46]:63124 "HELO
	smtp.localnet.com") by vger.kernel.org with SMTP id <S261514AbSKBXeE>;
	Sat, 2 Nov 2002 18:34:04 -0500
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: qconf buglet
References: <m3fzuj3imt.fsf_-_@lugabout.jhcloos.org>
	<Pine.LNX.4.44.0211022039290.6949-100000@serv>
From: "James H. Cloos Jr." <cloos@jhcloos.com>
In-Reply-To: <Pine.LNX.4.44.0211022039290.6949-100000@serv>
Date: 02 Nov 2002 18:40:25 -0500
Message-ID: <m33cqjsfpy.fsf@lugabout.jhcloos.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Roman" == Roman Zippel <zippel@linux-m68k.org> writes:

Roman> How do other qt apps behave? I'm not doing anything special
Roman> with fonts, so I don't see reason why this should be needed.

Ack.  I did further debugging with XFT_DEBUG and discovered that
"Helvetica" was getting matched to a rogue font.  I added a rule to
fonts.conf to force Helvetica to Arial and it now works.

I should have tested with XFT_DEBUG=1 before posting....

-JimC

