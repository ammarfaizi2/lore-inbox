Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263409AbSJGVkV>; Mon, 7 Oct 2002 17:40:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263410AbSJGVkV>; Mon, 7 Oct 2002 17:40:21 -0400
Received: from pc132.utati.net ([216.143.22.132]:44449 "HELO
	merlin.webofficenow.com") by vger.kernel.org with SMTP
	id <S263409AbSJGVkV>; Mon, 7 Oct 2002 17:40:21 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Steve Dover <swdlinunx@earthlink.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: PC speaker dead in 2.5.40?
Date: Mon, 7 Oct 2002 12:45:48 -0400
X-Mailer: KMail [version 1.3.1]
References: <3DA1BD31.4040707@earthlink.net>
In-Reply-To: <3DA1BD31.4040707@earthlink.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20021007214533.4AF18622@merlin.webofficenow.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 07 October 2002 12:58 pm, Steve Dover wrote:
> Configuring a kernel with Sound support with either
> OSS or ALSA, I still get nothing from my PC speaker.
> Works fine under 2.4.18.

make menuconfig

input_device_support->misc->pc_speaker_support.

Switch it on.

Rob
