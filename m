Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261383AbVF1WIJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261383AbVF1WIJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 18:08:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261530AbVF1WF4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 18:05:56 -0400
Received: from zproxy.gmail.com ([64.233.162.196]:34308 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261383AbVF1WFP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 18:05:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=aft6X5WQbtdr83OnzU92FFhYfjcAaANtWBQzarGZFNGhRrFUhe/epoDMTFDRXmH+lJx92vFSVsQpuDYrRnLsuCm/zlMuUkc/UR9ovDwgX0OgZO/Frqb1GQOu4At6mW4P7ajqnOOmEIU5tULL1pzuHAz2lkEbZlo6+0eRg3h1FqE=
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
Subject: Re: [PATCH 1/1]  V4L CX88 patch - against 2.6.12-mm2
Date: Wed, 29 Jun 2005 02:10:54 +0400
User-Agent: KMail/1.7.2
Cc: Jean Delvare <khali@linux-fr.org>, akpm@osdl.org,
       video4linux-list@redhat.com, linux-kernel@vger.kernel.org
References: <42C19F6A.6020501@brturbo.com.br> <20050628232157.214c76fd.khali@linux-fr.org>
In-Reply-To: <20050628232157.214c76fd.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506290210.54931.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 29 June 2005 01:21, Jean Delvare wrote:
> Your patch adds trailing whitespace in various places:
	[snip]
> Six people signing this patch and nobody noticed? Amazing.
> 
> Please fix, thanks.

Also:

> --- linux-2.6.12-mm2/drivers/media/video/cx88/cx88-core.c
> +++ linux/drivers/media/video/cx88/cx88-core.c

> +/* Used only on cx88-core */
>  static char *cx88_pci_irqs[32] = {

"static" already said that.

> +/* Used only on cx88-video */
>  char *cx88_vid_irqs[32] = {

So move it there.

> +/* Used only on cx88-mpeg */
>  char *cx88_mpeg_irqs[32] = {

Move this too.

> --- linux-2.6.12-mm2/drivers/media/video/cx88/cx88-input.c
> +++ linux/drivers/media/video/cx88/cx88-input.c

> +static IR_KEYTAB_TYPE ir_codes_msi_tvanywhere[IR_KEYTAB_SIZE] = {
> +       [ 0x00 ] = KEY_0,           /* '0' */          
> +       [ 0x01 ] = KEY_1,           /* '1' */
> +       [ 0x02 ] = KEY_2,           /* '2' */
> +       [ 0x03 ] = KEY_3,           /* '3' */
> +       [ 0x04 ] = KEY_4,           /* '4' */
> +       [ 0x05 ] = KEY_5,           /* '5' */
> +       [ 0x06 ] = KEY_6,           /* '6' */
> +       [ 0x07 ] = KEY_7,           /* '7' */
> +       [ 0x08 ] = KEY_8,           /* '8' */
> +       [ 0x09 ] = KEY_9,           /* '9' */
> +       [ 0x0c ] = KEY_MUTE,        /* 'Mute' */

Duplicating comments.

> +       [ 0x10 ] = KEY_F,           /* 'Funtion' */

Function.

> +       [ 0x12 ] = KEY_POWER,       /* 'Power' */

> +       [ 0x14 ] = KEY_SLOW,        /* 'Slow' */

Duplicating comments. 
