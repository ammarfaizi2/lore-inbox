Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161036AbWGUMf4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161036AbWGUMf4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 08:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161067AbWGUMf4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 08:35:56 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:53327 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1161036AbWGUMfz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 08:35:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=S514xCjBpFk1fNfT5aZ25LvZL48yd8PWCQ3txSv1t/ejl5qWLoCTM1wCVpMWGGVf6CyHG0AGjlrCGHLKmsXnnLCLhzlva9vf9Vsc/Z4DonQeXYt8r/LfmE5t6+2zlui66jBOfr8zT24UD5onI9/paY5hV6lx9sdxcAMpUChD5Xc=
Message-ID: <d120d5000607210535u6e8cad16u895cbb4671119dbc@mail.gmail.com>
Date: Fri, 21 Jul 2006 08:35:53 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Panagiotis Issaris" <takis@lumumba.uhasselt.be>
Subject: Re: [PATCH] drivers: Conversions from kmalloc+memset to k(z|c)alloc.
Cc: linux-kernel@vger.kernel.org, len.brown@intel.com, chas@cmf.nrl.navy.mil,
       miquel@df.uba.ar, kkeil@suse.de, benh@kernel.crashing.org,
       video4linux-list@redhat.com, rmk+mmc@arm.linux.org.uk,
       Neela.Kolli@engenio.com, jgarzik@pobox.com, vandrove@vc.cvut.cz,
       adaplas@pol.net, thomas@winischhofer.net, weissg@vienna.at,
       philb@gnu.org, linux-pcmcia@lists.infradead.org, jkmaline@cc.hut.fi,
       paulus@samba.org
In-Reply-To: <20060720190529.GC7643@lumumba.uhasselt.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060720190529.GC7643@lumumba.uhasselt.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/20/06, Panagiotis Issaris <takis@lumumba.uhasselt.be> wrote:
> From: Panagiotis Issaris <takis@issaris.org>
>
> drivers: Conversions from kmalloc+memset to k(z|c)alloc.
>
> Signed-off-by: Panagiotis Issaris <takis@issaris.org>
> ---
> Second edition
>
>  drivers/acpi/hotkey.c                      |    6 ++----
>  drivers/atm/zatm.c                         |    6 ++----
>  drivers/char/consolemap.c                  |    6 ++----
>  drivers/char/keyboard.c                    |    4 ++--

Hi,

Could you please drop drivers/char/keyboard.c changes? I already have
patch in my queue that does kzalloc conversion there (among other
things).

Thanks!

-- 
Dmitry
