Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313190AbSF0D7D>; Wed, 26 Jun 2002 23:59:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315690AbSF0D7C>; Wed, 26 Jun 2002 23:59:02 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:51447 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S313190AbSF0D7C>;
	Wed, 26 Jun 2002 23:59:02 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15642.36216.782111.506354@napali.hpl.hp.com>
Date: Wed, 26 Jun 2002 20:58:48 -0700
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andreas Schwab <schwab@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.24: auto_fs.h typo.
In-Reply-To: <3D19CE5E.1090704@zytor.com>
References: <200206251759.34690.schwidefsky@de.ibm.com>
	<afb4im$6nl$1@cesium.transmeta.com>
	<je7kkm8bma.fsf@sykes.suse.de>
	<3D19CE5E.1090704@zytor.com>
X-Mailer: VM 7.03 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Wed, 26 Jun 2002 10:23:26 -0400, "H. Peter Anvin" <hpa@zytor.com> said:

  hpa> Andreas Schwab wrote:
  >> |> |> Please change this to:
  >> |> 
  >> |> #ifndef __alpha__
  >> 
  >> What about __ia64__?

  hpa> Oh right, that one too...

Isn't this the one which we agreed not to change because it would break
existing ia64 automount binaries and because we do not expect x86 automount
to run on ia64 machines?

	--david
