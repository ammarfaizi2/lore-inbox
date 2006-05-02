Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932378AbWEBFl7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932378AbWEBFl7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 01:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932380AbWEBFl7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 01:41:59 -0400
Received: from pproxy.gmail.com ([64.233.166.183]:31596 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932378AbWEBFl6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 01:41:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=EOMMpPEZjCRKSh7ZrUq4Zv/pRwoh3hpkdI6x0h8xnf+EZNy29bW23qysvs+M3MwXHMId/02Q3sO6HogczOLHgLhm5IE+UdpB2BpkaGyB+GsmS+pZFbcEBjPoO9jOckD3watsKguomQtfF5dDuntUZFSK0CkZj/8XuJKsUlubOqo=
Message-ID: <4456EA3B.3080507@gmail.com>
Date: Tue, 02 May 2006 13:12:27 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: =?UTF-8?B?zrrLpw==?= <cpuwolf@gmail.com>
CC: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: frame buffer driver
References: <a6f9b16b0605011955t4ade42bbi8c12a741463a8996@mail.gmail.com>
In-Reply-To: <a6f9b16b0605011955t4ade42bbi8c12a741463a8996@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

κ˧ wrote:
> Dear ,
>    I have written a framebuffer driver for my OMAP850 platform LCD
> controller.linux logo and kernel debug message can show now.But screen
> is "shaking".Just like,for every pixel,black and white,black and
> white........at high frequency.Is there any kernel thread refresh
> console?? Or I have some error in my driver?

Make sure you're using correct timings.  Depending on the driver, you
can use fbset to do that.

Tony

