Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261151AbVAGKh5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbVAGKh5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 05:37:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261181AbVAGKh5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 05:37:57 -0500
Received: from dsl081-060-252.sfo1.dsl.speakeasy.net ([64.81.60.252]:41396
	"EHLO vitelus.com") by vger.kernel.org with ESMTP id S261151AbVAGKhv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 05:37:51 -0500
Date: Fri, 7 Jan 2005 02:37:50 -0800
From: Aaron Lehmann <aaronl@vitelus.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Open hardware wireless cards
Message-ID: <20050107103750.GF3228@vitelus.com>
References: <20050105200526.GL5159@ruslug.rutgers.edu> <41DC4B43.7090109@imag.fr> <20050105202626.GN5159@ruslug.rutgers.edu> <200501060902.07502.norbert-kernel@edusupport.nl> <20050106172438.GT5159@ruslug.rutgers.edu> <1105033035.15352.0.camel@krustophenia.net> <1105034339.24896.228.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1105034339.24896.228.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2005 at 05:59:01PM +0000, Alan Cox wrote:
> Audio is easy. Good audio is rocket science. You can roll yourself a USB
> audio interface with a microcontroller and a codec ic. Getting that to
> give you a really good signal/noise ratio is then rather trickier.

Actually you don't even need a microcontroler: use an IC like the TI
PCM2902 (http://focus.ti.com/docs/prod/folders/print/pcm2902.html). I
built a headphone amplifier that uses one and I'm very pleased -
especially because there's digital passthrough for my speakers via
S/PDIF. The quality is nothing special, but you can always
plug a high-end codec into the S/PDIF I/O. I saw a schematic
somewhere that used the PCM2902 as the USB-audio interface along with
a high end DAC. However if you need more than 16 bits and 48kHz you
might need to make something more fancy.
