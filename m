Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265909AbTBFM1l>; Thu, 6 Feb 2003 07:27:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267026AbTBFM1l>; Thu, 6 Feb 2003 07:27:41 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:24242 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S265909AbTBFM1l>;
	Thu, 6 Feb 2003 07:27:41 -0500
Date: Thu, 6 Feb 2003 12:33:40 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Jurriaan <thunder7@xs4all.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.59 won't boot, 2.5.58 will, how to I use bitkeeper to get 'in between' ?
Message-ID: <20030206123340.GA3305@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Jurriaan <thunder7@xs4all.nl>, linux-kernel@vger.kernel.org
References: <20030206060742.GA6458@middle.of.nowhere>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030206060742.GA6458@middle.of.nowhere>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 06, 2003 at 07:07:42AM +0100, Jurriaan wrote:
 > Until now, all 2.5.59-based kernels (2.5.59 vanilla, 2.5.59 + vmlinux
 > patch, 2.5.59-mm[1-8]) hang very early in the boot-process on my system,
 > right after 'Uncompressing Linux...'

Two suspects (from freezing boxes Ive had here) are ACPI and PNP. Try
disabling those first.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
