Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314058AbSEMP0d>; Mon, 13 May 2002 11:26:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314061AbSEMP0c>; Mon, 13 May 2002 11:26:32 -0400
Received: from mail0.epfl.ch ([128.178.50.57]:25363 "HELO mail0.epfl.ch")
	by vger.kernel.org with SMTP id <S314058AbSEMP0b>;
	Mon, 13 May 2002 11:26:31 -0400
Message-ID: <3CDFDB26.5070509@epfl.ch>
Date: Mon, 13 May 2002 17:26:30 +0200
From: Nicolas Aspert <Nicolas.Aspert@epfl.ch>
Organization: LTS-DE-EPFL
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc2) Gecko/20020510
X-Accept-Language: en-us, ja
MIME-Version: 1.0
To: graeme fisher <graeme@2d3d.co.za>
CC: linux-kernel@vger.kernel.org
Subject: Re: Agpgart for 845G
In-Reply-To: <fa.cfjurcv.v30q20@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

> 
> Patch for Intel 845G agpgart support
> 

diff'd against which version of the kernel ?


> +    { PCI_DEVICE_ID_INTEL_845_G_0,
> +		 PCI_VENDOR_ID_INTEL,
> +		 INTEL_I845_G,
> +		 "Intel",
> +		 "i845G",
> +		 intel_830mp_setup },

Are you sure that 830mp and 845g have exactly the same addresses to 
write/read to ? BTW, I can't find any datasheet for 845g on Intel's 
website ... do you have any at hand ?



> +			if (i810_dev == NULL) {
> +                                /* 
> +                                 * We probably have a I830MP chipset
> +                                 * with an external graphics
> +                                 * card. It will be initialized later 
> +                                 */
> +				agp_bridge.type = INTEL_I845_G;
> +				break;
> +			}

Are you sure about the comment :-)) ?



a+

Nicolas.
PS: CC any answer to me, I am not on the list...
-- 
Nicolas Aspert      Signal Processing Institute (ITS)
Swiss Federal Institute of Technology (EPFL)


