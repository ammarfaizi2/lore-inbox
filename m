Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267392AbTBQTPT>; Mon, 17 Feb 2003 14:15:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267393AbTBQTPT>; Mon, 17 Feb 2003 14:15:19 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:33811 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S267392AbTBQTPT>;
	Mon, 17 Feb 2003 14:15:19 -0500
Message-ID: <3E5136F9.9090709@pobox.com>
Date: Mon, 17 Feb 2003 14:24:41 -0500
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: "H. Peter Anvin" <hpa@zytor.com>, kai@tp1.ruhr-uni-bochum.de,
       greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC] klibc for 2.5.59 bk
References: <20030209125759.GA14981@kroah.com> <Pine.LNX.4.44.0302162057200.5217-100000@chaos.physics.uiowa.edu> <20030217180246.GA26112@mars.ravnborg.org> <1911.212.181.176.76.1045505249.squirrel@www.zytor.com> <3E512BCB.1010000@pobox.com> <20030217185700.GA27610@mars.ravnborg.org>
In-Reply-To: <20030217185700.GA27610@mars.ravnborg.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:
> On Mon, Feb 17, 2003 at 01:36:59PM -0500, Jeff Garzik wrote:
> 
>> 
>>+check_gcc = $(shell if $(CC) $(1) -S -o /dev/null -xc /dev/null > /dev/null 2>&1; then echo "$(1)"; else echo "$(2)"; fi)
> 
> 
> Will check_gcc be compatible across architectures?


s/will/is/   Yes.

	Jeff



