Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266223AbUAGObP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 09:31:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266225AbUAGObP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 09:31:15 -0500
Received: from inet-mail4.oracle.com ([148.87.2.204]:31171 "EHLO
	inet-mail4.oracle.com") by vger.kernel.org with ESMTP
	id S266223AbUAGObK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 09:31:10 -0500
Message-ID: <3FFC17BD.80000@oracle.com>
Date: Wed, 07 Jan 2004 15:29:17 +0100
From: Alessandro Suardi <alessandro.suardi@oracle.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20031119
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [solved] no ALSA sound in 2.6 on Intel 82801CA-ICH3 - OSS works
References: <3FFBF379.6080301@oracle.com>
In-Reply-To: <3FFBF379.6080301@oracle.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alessandro Suardi wrote:
> I'm a bit ashamed about posting this, but I couldn't find anyone with
>  a similar problem googling. I admit up front that I'm ALSA-ignorant
>  so this could well be a silly configuration issue...

[snipped the /proc/asound details]

And it was; thanks to Gunther Sohler who tipped me the right way I
  installed the software I was missing (alsa-lib, alsa-driver and
  alsa-tools plus the xmms-alsa plugin), unmuted the audio channels
  by means of alsamixer (*the* problem - somehow the channels are
  muted by default), set volume for what I use and now xine/xmms
  play audio fine.

As a bonus I cleared my mind about a few differences between ALSA
  and OSS :)


Sorry for the waste of bandwidth and thanks again,

--alessandro

  "Immagina intensamente e vedrai
    dove gli altri pensano che non ci sia niente"
       (Cristina Dona', "Salti nell'aria")

