Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261850AbTLPQFy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 11:05:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261863AbTLPQFy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 11:05:54 -0500
Received: from fw.osdl.org ([65.172.181.6]:3263 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261850AbTLPQFx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 11:05:53 -0500
Date: Tue, 16 Dec 2003 07:57:03 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Karel =?ISO-8859-1?Q?Kulhav=FD?= <clock@twibright.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test11 make menuconfig bugreport
Message-Id: <20031216075703.75573a58.rddunlap@osdl.org>
In-Reply-To: <20031216150252.A722@beton.cybernet.src>
References: <20031216150252.A722@beton.cybernet.src>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Dec 2003 15:02:52 +0100 Karel Kulhavý <clock@twibright.com> wrote:

| Device Drivers ->
| Input device support ->
| --- Mouse interface <Help>
| "Say Y here if you want [...] If unsure, say Y."
| There is no way how to say anything here. It's a fixed
| entry beginning with "---"


config INPUT_MOUSEDEV
	tristate "Mouse interface" if EMBEDDED
	default y
	depends on INPUT

so if you set EMBEDDED (means that you want more config control),
you can mess with INPUT_MOUSEDEV.  It also implies that you
know what you are doing....

--
~Randy
MOTD:  Always include version info.
