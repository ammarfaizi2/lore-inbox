Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129131AbRBXRN1>; Sat, 24 Feb 2001 12:13:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129333AbRBXRNR>; Sat, 24 Feb 2001 12:13:17 -0500
Received: from quattro.sventech.com ([205.252.248.110]:36872 "HELO
	quattro.sventech.com") by vger.kernel.org with SMTP
	id <S129131AbRBXRNP>; Sat, 24 Feb 2001 12:13:15 -0500
Date: Sat, 24 Feb 2001 12:13:13 -0500
From: Johannes Erdfelt <johannes@erdfelt.com>
To: Pifko Krisztian <pifko@kirowski.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] philips rush usb support
Message-ID: <20010224121312.S16341@sventech.com>
In-Reply-To: <Pine.LNX.4.30.0102241730370.19866-100000@pifko.kirowski.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4i
In-Reply-To: <Pine.LNX.4.30.0102241730370.19866-100000@pifko.kirowski.com>; from Pifko Krisztian on Sat, Feb 24, 2001 at 05:39:32PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 24, 2001, Pifko Krisztian <pifko@kirowski.com> wrote:
> I've made a patch which adds usb support for the philips
> rush mp3 player. The driver is mainly the rio500 driver
> only the rush specific parts were modified.
> 
> The patch is against 2.4.2.
> 
> It uses char 180 65 at /dev/usb/rush.
> 
> Userspace stuff should be found at http://openrush.sourceforge.net
> if you have a rush. It works for me on ia32 with the model sa125.

Why can't the entire driver be in userspace? It appears it uses a
completely proprietary protocol and you've created a completely
proprietary interface to the kernel.

JE

