Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316982AbSFKJ5Z>; Tue, 11 Jun 2002 05:57:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316985AbSFKJ5Y>; Tue, 11 Jun 2002 05:57:24 -0400
Received: from mail.pixelwings.com ([194.152.163.212]:4362 "EHLO
	pixelwings.com") by vger.kernel.org with ESMTP id <S316982AbSFKJ5X> convert rfc822-to-8bit;
	Tue, 11 Jun 2002 05:57:23 -0400
Date: Tue, 11 Jun 2002 11:57:22 +0200
From: Clemens Schwaighofer <cs@pixelwings.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.20-dj4 oss broken.
Message-ID: <24980000.1023789442@[192.168.1.172]>
In-Reply-To: <20020610195715.Z13140@suse.de>
X-Mailer: Mulberry/2.2.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dave Jones

--On Monday, June 10, 2002 07:57:15 PM +0200 you wrote:

> On Mon, Jun 10, 2002 at 07:42:16PM +0200, Clemens Schwaighofer wrote:
>  > ac97_codec.c:116: label ad1886_ops referenced outside of any function
>
> Typo. There is a && at the end of that line which should just be a
> single &

yip, this fixes it.

-- 
"Der Krieg ist ein Massaker von Leuten, die sich nicht kennen, zum
Nutzen von Leuten, die sich kennen, aber nicht massakrieren"
- Paul Valéry (1871-1945)
mfg, Clemens Schwaighofer                       PIXELWINGS Medien GMBH
Kandlgasse 15/5, A-1070 Wien                      T: [+43 1] 524 58 50
JETZT NEU! MIT FEWA GEWASCHEN       -->      http://www.pixelwings.com
