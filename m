Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263977AbTARJ3f>; Sat, 18 Jan 2003 04:29:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264001AbTARJ3f>; Sat, 18 Jan 2003 04:29:35 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:27655 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S263977AbTARJ3e>;
	Sat, 18 Jan 2003 04:29:34 -0500
Date: Sat, 18 Jan 2003 10:37:43 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Jurriaan <thunder7@xs4all.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.59 doesn't boot - hangs after 'Uncompressing the kernel'
Message-ID: <20030118093743.GB1483@mars.ravnborg.org>
Mail-Followup-To: Jurriaan <thunder7@xs4all.nl>,
	linux-kernel@vger.kernel.org
References: <20030118081408.GA1163@middle.of.nowhere>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030118081408.GA1163@middle.of.nowhere>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 18, 2003 at 09:14:08AM +0100, Jurriaan wrote:
> I can't get 2.5.59 to boot on my dual tualatin/via PRO266T system.
> It hangs early in the boot-process, I don't see anything after the
> 'Uncompressing the kernel' line. The keyboard led's stuck then as well,
> and waiting doesn't help.

People have problems after recent changes in vmlinux.lds.

Try apply the vmlinux patch from Andrew's set of patches:
http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.59/2.5.59-mm2/

Usually report is an oops, but that may be UP only.

	Sam
