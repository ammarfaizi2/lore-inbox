Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287234AbSALSLl>; Sat, 12 Jan 2002 13:11:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287237AbSALSLc>; Sat, 12 Jan 2002 13:11:32 -0500
Received: from waste.org ([209.173.204.2]:25762 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S287234AbSALSLV>;
	Sat, 12 Jan 2002 13:11:21 -0500
Date: Sat, 12 Jan 2002 12:11:09 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: "Eric S. Raymond" <esr@snark.thyrsus.com>
cc: linux-kernel@vger.kernel.org, <greg@kroah.com>, <felix-dietlibc@fefe.de>
Subject: Re: initramfs programs (was [RFC] klibc requirements)
In-Reply-To: <200201092005.g09K5OL28043@snark.thyrsus.com>
Message-ID: <Pine.LNX.4.43.0201121207260.3568-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jan 2002, Eric S. Raymond wrote:

> greg k-h:
> >What does everyone else need/want there?
>
> dmidecode, so the init script can dump a DMI report in a known
> location such as /var/run/dmi.

No, this belongs in a distribution's init scripts. Initramfs is stuff that
is needed before mounting real root, not everything that must be done
before we have a login prompt.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

