Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315431AbSHITBJ>; Fri, 9 Aug 2002 15:01:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315439AbSHITBJ>; Fri, 9 Aug 2002 15:01:09 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:37864 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S315431AbSHITBJ>;
	Fri, 9 Aug 2002 15:01:09 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15700.4689.876752.886309@napali.hpl.hp.com>
Date: Fri, 9 Aug 2002 12:04:49 -0700
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Arnd Bergmann <arnd@bergmann-dalldorf.de>, linux-kernel@vger.kernel.org
Subject: Re: klibc development release
In-Reply-To: <3D541018.4050004@zytor.com>
References: <aivdi8$r2i$1@cesium.transmeta.com>
	<200208090934.g799YVZe116824@d12relay01.de.ibm.com>
	<200208091754.g79HsJkN058572@d06relay02.portsmouth.uk.ibm.com>
	<3D541018.4050004@zytor.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Fri, 09 Aug 2002 11:55:20 -0700, "H. Peter Anvin" <hpa@zytor.com> said:

  HPA> Hmf... some of these seem to be outright omissions
  HPA> (pivot_root() and umount2() especially), and probably indicate
  HPA> bugs or that the stock kernel isn't up to date anymore.

  HPA> I can see umount() being missing (as in "use umount2()").

Alpha calls umount2() "oldumount"; ia64 never had a one-argument
version of umount(), so there is no point creating legacy (and the
naming is inconsistent anyhow...).

	--david
